local M = {}

local profiles = {
  default = {
    colorscheme = "tokyonight",
    lualine = "tokyonight",
    tokyonight_style = "moon",
  },
  pUSER = {
    colorscheme = "nord",
    lualine = "nord",
  },
}

local nord = {
  polar_night = {
    nord0 = "#2E3440",
    nord1 = "#3B4252",
    nord2 = "#434C5E",
    nord3 = "#4C566A",
  },
  snow_storm = {
    nord4 = "#D8DEE9",
    nord5 = "#E5E9F0",
    nord6 = "#ECEFF4",
  },
  frost = {
    nord7 = "#8FBCBB",
    nord8 = "#88C0D0",
    nord9 = "#81A1C1",
    nord10 = "#5E81AC",
  },
  aurora = {
    nord11 = "#BF616A",
    nord13 = "#EBCB8B",
  },
}

local function merge_profile(profile)
  return vim.tbl_deep_extend("force", {}, profiles.default, profile or {})
end

function M.current(username)
  local wanted = username
  if wanted == nil then
    wanted = vim.env.GIT_USERNAME
  end

  local name = profiles[wanted] and wanted or "default"
  local profile = merge_profile(profiles[name])
  profile.name = name
  profile.username = wanted

  return profile
end

function M.colorscheme()
  return M.current().colorscheme
end

function M.lualine_theme()
  return M.current().lualine or M.current().colorscheme
end

function M.load_colorscheme()
  local profile = M.current()
  if profile.background then
    vim.o.background = profile.background
  end
  vim.cmd.colorscheme(profile.colorscheme)
end

local function nord_bufferline()
  return {
    fill = { bg = nord.polar_night.nord0 },
    background = { fg = nord.snow_storm.nord4, bg = nord.polar_night.nord0 },
    buffer_visible = { fg = nord.snow_storm.nord5, bg = nord.polar_night.nord1 },
    buffer_selected = { fg = nord.snow_storm.nord6, bg = nord.polar_night.nord2, bold = true },
    modified = { fg = nord.aurora.nord13, bg = nord.polar_night.nord0 },
    modified_visible = { fg = nord.aurora.nord13, bg = nord.polar_night.nord1 },
    modified_selected = { fg = nord.aurora.nord13, bg = nord.polar_night.nord2 },
    separator = { fg = nord.polar_night.nord0, bg = nord.polar_night.nord0 },
    separator_visible = { fg = nord.polar_night.nord0, bg = nord.polar_night.nord1 },
    separator_selected = { fg = nord.polar_night.nord0, bg = nord.polar_night.nord2 },
    indicator_selected = { fg = nord.frost.nord8, bg = nord.polar_night.nord2 },
    close_button = { fg = nord.polar_night.nord3, bg = nord.polar_night.nord0 },
    close_button_visible = { fg = nord.frost.nord8, bg = nord.polar_night.nord1 },
    close_button_selected = { fg = nord.frost.nord8, bg = nord.polar_night.nord2 },
    diagnostic = { fg = nord.polar_night.nord3, bg = nord.polar_night.nord0 },
    error = { fg = nord.aurora.nord11, bg = nord.polar_night.nord0 },
    error_selected = { fg = nord.aurora.nord11, bg = nord.polar_night.nord2, bold = true },
    warning = { fg = nord.aurora.nord13, bg = nord.polar_night.nord0 },
    warning_selected = { fg = nord.aurora.nord13, bg = nord.polar_night.nord2, bold = true },
  }
end

function M.bufferline_highlights()
  local profile = M.current()

  if profile.bufferline then
    return profile.bufferline
  end

  if profile.colorscheme:find("^catppuccin") then
    local ok, catppuccin = pcall(require, "catppuccin.special.bufferline")
    if ok then
      return catppuccin.get_theme()
    end
  end

  if profile.colorscheme == "nord" then
    return nord_bufferline()
  end
end

return M
