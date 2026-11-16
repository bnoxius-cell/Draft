# Decisions

One line each, newest first. Format: `date: decision (why)`

- 2026-11-16: Tools pinned in aftman.toml: Rojo 7.7.1, selene 0.32.0, StyLua 2.6.0 (Rokit and Aftman both read aftman.toml).
- 2026-11-16: Remotes are created by the server through src/shared/Net.luau and named "<Feature>/<Action>" (no hand-placed remotes, no central names file both people edit).
- 2026-11-16: Each side has one bootstrap that starts every feature with init() then start() (adding a feature never edits a shared file).
- 2026-11-16: Ownership is per feature, covering its server, client and shared folders, plus Core and Project setup rows (no parent-folder claims, so no file is shared between two claims).
- 2026-11-16: Scripts are tested in each person's local test place, and only main is synced into the Team Create place (two Rojo sessions in one Team Create place overwrite and delete each other's scripts).
