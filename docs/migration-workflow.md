# Migration Workflow

Use this workflow when adding another plugin from `prev_cfg/` or promoting a
deferred integration into active work.

## Promote Work Into TODO

1. Move exactly one plugin or tightly coupled plugin group into the `## todo`
   section of `TODO.md`.
2. Remove the `No active migration items.` marker while active items exist.
3. Keep prerequisites in `## deferred` until they are available and verified,
   especially external binaries that Mason must not install.

## Implement The Plugin

1. Add or update a modular spec under `lua/plugins/`.
2. Prefer LazyVim extras, Mini modules, or Neovim native features before adding
   another plugin.
3. Preserve useful behavior from `prev_cfg/` only when it still fits the
   LazyVim baseline.
4. Configure missing external tools as optional. The config must start cleanly
   when optional binaries are absent.

## Update Documentation

1. Move completed items from `## todo` to `## done` in `TODO.md`.
2. Update `docs/plugins.md` with the plugin name, config path, description, and
   notes.
3. Update `docs/keymaps.md` when the plugin adds or changes keymaps.
4. Update `docs/migration-decisions.md` when replacing, omitting, or deferring
   behavior from `prev_cfg/`.
5. Update `docs/external-tools.md` if the plugin can use external binaries.

## Verify

Run the full local verification target:

```bash
make verify
```

For changes that affect healthcheck findings, also run:

```bash
make healthcheck
```

Do not treat existing healthcheck findings as plugin migration failures unless
the current plugin change introduces a new error or warning.

