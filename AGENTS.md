# Instructions for Agents

## Code Style
- Use two spaces for indentation in Lua files.
- Keep plugin configurations modular under the `lua/` directory.
- Avoid trailing whitespace and ensure each file ends with a newline.

## Commit Guidelines
- Write clear, concise commit messages in the imperative mood.

## Testing
Run the headless startup test to verify that the configuration loads without errors or warnings:

```bash
tests/run.sh
```

This script launches Neovim in headless mode and fails if any errors or warnings occur during startup.
