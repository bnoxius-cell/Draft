# Ownership

Two states: FREE or CLAIMED. Steps for claiming and releasing are in `CLAUDE.md`. Only change a row you're claiming or releasing. Never change a row the other person has claimed.

What each row covers:
- `Feature: <Name>` covers `src/server/<Name>`, `src/client/<Name>` and `src/shared/<Name>`, whichever exist. Add the row, already CLAIMED, when you start a new feature. Keep feature rows in alphabetical order below the fixed rows.
- `Core` covers `src/server/Main.server.luau`, `src/client/Main.client.luau`, `src/shared/Bootstrap.luau`, `src/shared/Net.luau` and `src/shared/Util/`.
- `Project setup` covers `CLAUDE.md`, `README.md`, `docs/`, `.claude/`, `default.project.json`, `aftman.toml`, `selene.toml`, `stylua.toml`, `.luaurc`, `.gitignore` and `.gitattributes`.
- `Studio:` rows are parts of the Team Create place. Rojo doesn't manage them and they have no branch.
- `Team Create sync and publishing`: only the holder syncs `main` into the Team Create place or publishes.

There are no parent claims. To work on two features, claim both rows. A feature that needs a new ScreenGui also needs the `Studio: StarterGui (UI layout)` row, or a request in `STATUS.md`.

A claim more than 3 days old with no handoff entry about it: tell the user so they can ask the other person. Never change it yourself.

| Area | Status | Owner | Since |
|---|---|---|---|
| Core | FREE | | |
| Project setup | FREE | | |
| Studio: Workspace/Map | FREE | | |
| Studio: StarterGui (UI layout) | FREE | | |
| Studio: Lighting and Terrain | FREE | | |
| Team Create sync and publishing | FREE | | |
