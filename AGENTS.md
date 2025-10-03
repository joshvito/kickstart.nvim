1. Build/Run: No compile step; config auto-loaded by Neovim (latest stable/nightly recommended).
2. Dependencies: See README (git, ripgrep, fd, make, C compiler, optional Nerd Font) before running.
3. Plugin sync/update (headless): nvim --headless "+Lazy! sync" +qa (repeat after editing plugin specs).
4. Health/self-test: nvim --headless "+checkhealth" +qa (treat clean run as basic test suite).
5. Format all Lua: stylua .  (config: .stylua.toml; CI uses --check only).
6. Check formatting only (CI parity): stylua --check .; format single file: stylua path/to/file.lua.
7. No formal unit tests; rely on headless startup + :checkhealth + functional manual validation.
8. Add plugins via lazy spec tables in lua/custom/plugins/*.lua; keep init.lua readable and minimal.
9. Import order: standard/libs & 'vim' first; plugin requires next; custom modules last; avoid global assignments.
10. Scope: always prefer local vars; avoid polluting _G; descriptive lower_snake_case names.
11. Styling: 2-space indent; column <=160; Unix line endings; single quotes preferred (Stylua enforces); no trailing spaces.
12. Function style: pure where practical; early returns favored; keep concise; split large config blocks into helper modules.
13. Tables: trailing commas optional; let Stylua normalize; omit parentheses for simple calls (call_parentheses=None).
14. Keymaps: use vim.keymap.set with desc; group LSP maps inside LspAttach autocmd; avoid silent = true unless noisy.
15. Error handling: pcall optional plugin loads; fail fast (error) only on critical bootstrap (e.g., lazy clone failure).
16. Naming: modules/files lower_snake_case; constants ALL_CAPS only if truly immutable; TODO items prefixed with TODO:.
17. Comments: brief, above non-obvious logic; large documentation stays in README or leading block comments.
18. Formatting gate: run stylua before PR; CI workflow (.github/workflows/stylua.yml) rejects unformatted code.
19. Plugin specs: keys (opts, config, dependencies, event, ft, build) only when needed; keep diffs small & focused.
20. No Cursor or Copilot rule files present; follow this file + README for all agent actions.