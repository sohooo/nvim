#!/usr/bin/env bash

airgap_die() {
  echo "error: $*" >&2
  exit 1
}

airgap_need() {
  command -v "$1" >/dev/null 2>&1 || airgap_die "missing required command: $1"
}

airgap_sha256_file() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{ print $1 }'
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{ print $1 }'
  else
    airgap_die "missing sha256sum or shasum"
  fi
}

airgap_json_escape() {
  sed 's/\\/\\\\/g; s/"/\\"/g'
}

airgap_json_array() {
  local first=1
  printf '['
  while IFS= read -r item; do
    [[ -n "$item" ]] || continue
    if [[ "$first" -eq 0 ]]; then
      printf ','
    fi
    first=0
    printf '"%s"' "$(printf '%s' "$item" | airgap_json_escape)"
  done
  printf ']'
}

airgap_extract_asset_field() {
  local asset="$1"
  local field="$2"

  awk -v asset="$asset" -v field="$field" '
    $0 ~ "\"name\": \"" asset "\"" { in_asset = 1 }
    in_asset && $0 ~ "\"" field "\":" {
      line = $0
      sub("^.*\"" field "\": *\"", "", line)
      sub("\".*$", "", line)
      print line
      exit
    }
    in_asset && $0 ~ /^    \}/ { in_asset = 0 }
  '
}

airgap_treesitter_languages() {
  awk '
    /local parser_languages = \{/ { in_list = 1; next }
    in_list && /\}/ { exit }
    in_list {
      while (match($0, /"[^"]+"/)) {
        value = substr($0, RSTART + 1, RLENGTH - 2)
        print value
        $0 = substr($0, RSTART + RLENGTH)
      }
    }
  ' "$ROOT/lua/plugins/treesitter.lua"
}

airgap_plugin_names() {
  sed -n 's/^  "\([^"]*\)":.*/\1/p' "$ROOT/lazy-lock.json"
}

airgap_lock_field() {
  local plugin="$1"
  local field="$2"

  awk -v plugin="$plugin" -v field="$field" '
    index($0, "\"" plugin "\":") {
      line = $0
      sub("^.*\"" field "\": *\"", "", line)
      sub("\".*$", "", line)
      print line
      exit
    }
  ' "$ROOT/lazy-lock.json"
}

airgap_bootstrap_lazy_nvim() {
  local data_root="$1"
  local lazy_dir="$data_root/lazy/lazy.nvim"
  local lazy_branch
  local lazy_commit

  lazy_branch="$(airgap_lock_field lazy.nvim branch)"
  lazy_commit="$(airgap_lock_field lazy.nvim commit)"

  [[ -n "$lazy_branch" ]] || airgap_die "lazy.nvim branch missing from lazy-lock.json"
  [[ -n "$lazy_commit" ]] || airgap_die "lazy.nvim commit missing from lazy-lock.json"

  mkdir -p "$(dirname "$lazy_dir")"
  git clone --filter=blob:none --branch "$lazy_branch" https://github.com/folke/lazy.nvim.git "$lazy_dir"
  git -C "$lazy_dir" checkout --detach "$lazy_commit"
  [[ "$(git -C "$lazy_dir" rev-parse HEAD)" == "$lazy_commit" ]] || airgap_die "failed to pin lazy.nvim to $lazy_commit"
}

airgap_pin_plugins_to_lock() {
  local data_root="$1"
  local plugin
  local plugin_dir
  local commit

  while IFS= read -r plugin; do
    [[ -n "$plugin" ]] || continue
    plugin_dir="$data_root/lazy/$plugin"
    commit="$(airgap_lock_field "$plugin" commit)"

    [[ -n "$commit" ]] || airgap_die "$plugin commit missing from lazy-lock.json"
    [[ -d "$plugin_dir/.git" ]] || continue

    if ! git -C "$plugin_dir" cat-file -e "$commit^{commit}" >/dev/null 2>&1; then
      git -C "$plugin_dir" fetch --filter=blob:none origin "$commit"
    fi

    git -C "$plugin_dir" checkout --detach "$commit"
    [[ "$(git -C "$plugin_dir" rev-parse HEAD)" == "$commit" ]] || airgap_die "failed to pin $plugin to $commit"
  done < <(airgap_plugin_names)
}

airgap_write_build_lua_scripts() {
  local build_dir="$1"
  local context="$2"

  cat >"$build_dir/restore-lazy.lua" <<'LUA'
local function fail(message)
  vim.api.nvim_err_writeln(message)
  vim.cmd("cquit 1")
end

local ok, err = xpcall(function()
  require("lazy.manage").restore({ wait = true, show = false })
end, debug.traceback)

if not ok then
  fail(err)
end

vim.cmd("quitall!")
LUA

  cat >"$build_dir/check-lazy-restore.lua" <<'LUA'
local function fail(message)
  vim.api.nvim_err_writeln(message)
  vim.cmd("cquit 1")
end

local Config = require("lazy.core.config")
local Git = require("lazy.manage.git")
local Lock = require("lazy.manage.lock")

Lock._loaded = false
Lock.load()

local failures = {}

for _, plugin in pairs(Config.plugins) do
  if plugin.url and not plugin._.is_local then
    local lock = Lock.get(plugin)
    if not lock then
      table.insert(failures, plugin.name .. " is active but missing from lazy-lock.json")
    elseif not plugin._.installed then
      table.insert(failures, plugin.name .. " is active but was not installed")
    else
      local info = Git.info(plugin.dir)
      if info.commit ~= lock.commit then
        table.insert(failures, plugin.name .. " is at " .. tostring(info.commit) .. " instead of " .. lock.commit)
      end
    end
  end
end

if #failures > 0 then
  fail("lazy restore verification failed:\n" .. table.concat(failures, "\n"))
end

vim.cmd("quitall!")
LUA

  cat >"$build_dir/install-treesitter.lua" <<LUA
local function fail(message)
  vim.api.nvim_err_writeln(message)
  vim.cmd("cquit 1")
end

local ok, err = xpcall(function()
  require("lazy.core.loader").load({ "nvim-treesitter" }, { cmd = "airgap ${context}" })

  local languages = vim.split(vim.env.AIRGAP_TS_LANGUAGES or "", "%s+", { trimempty = true })
  if #languages == 0 then
    error("AIRGAP_TS_LANGUAGES is empty")
  end

  local install = require("nvim-treesitter.install").install
  for _, language in ipairs(languages) do
    local task = install({ language }, { summary = true })
    local success = task:wait()
    if not success then
      error("failed to install Treesitter parser: " .. language)
    end
  end
end, debug.traceback)

if not ok then
  fail(err)
end

vim.cmd("quitall!")
LUA
}
