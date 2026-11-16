# Team rules (two people, two Claudes, one Roblox game)

Read this at the start of every session. It applies to both people and both Claudes. Inside this repo, this file wins over any personal or global instructions where they differ.

## Hard rules (no exceptions)
1. **Scripts exist only as files in `src/`.** Never create, edit, move or delete a script in Studio's script editor or through the Roblox_Studio MCP. That includes `multi_edit`, `execute_luau` code that creates scripts or sets `.Source`, generation tools that add scripted models, and Creator Store models that contain scripts. Rojo overwrites script edits made in Studio, and they never reach Git. The one exception: right after inserting a Creator Store model, delete any Script, LocalScript or ModuleScript inside it.
2. The Studio MCP is for reading and non-script work only: inspecting the tree, reading the console, play-testing, screenshots, and placing or adjusting map and UI instances in areas you've claimed.
3. Only edit areas you've claimed in `OWNERSHIP.md`.
4. Get the latest `main` before you start work or run `rojo serve` (see "Start of every session").
5. Nothing is "done" until it ran without errors in a Studio play-test.

If a task seems to need breaking one of these, stop and ask the user. `.claude/settings.json` blocks some Studio MCP tools and asks before others. Never work around those rules or prompts.

## Who you're working with
Each person has a `CLAUDE.local.md` in the repo root (Git ignores it) with one line: `The user here is <name>.` The name is their GitHub username in lowercase. Read it if it isn't already loaded. Use exactly that name for their handoff file, the Owner column in `OWNERSHIP.md` and branch names.
If `CLAUDE.local.md` is missing, this is a first session on this machine. Follow `docs/first-session.md` before anything else.

## How the project is set up
- One shared Git repo on GitHub, main branch `main`.
- **Scripts** are files in `src/` and sync into Studio with Rojo (`default.project.json`):
  - `src/server` -> ServerScriptService/Server
  - `src/client` -> StarterPlayer/StarterPlayerScripts/Client
  - `src/shared` -> ReplicatedStorage/Shared
  Rojo owns those three folders in Studio and deletes anything inside them that isn't a file in `src/`. Never put instances there by hand.
- **Everything else** (map, models, UI layout, lighting, terrain) lives in the Team Create place. Rojo doesn't touch it and it isn't in Git.
- Tools (Rojo, selene, StyLua) are pinned in `aftman.toml`. Rokit and Aftman both read it.
- Shared notes: `OWNERSHIP.md` (who has what), `STATUS.md`, `DECISIONS.md`. Personal notes: `handoffs/<name>.md`. Plans: `plans/`.

## Where you test (Rojo and Team Create)
Two Rojo sessions in one Team Create place overwrite and delete each other's scripts. So:
- **Test scripts in your own test place.** Open the Team Create place, use File > Save to File As and save it as `test-place.rbxl` in the repo root (Git ignores `.rbxl` files). Open that file, run `rojo serve` in the repo and connect the Rojo plugin. Play-test there. Save a fresh copy when you need the latest map or UI.
- **Do map and UI work in the Team Create place.** Changes made in your test place are lost.
- **Scripts reach the Team Create place only from `main`**, synced by whoever holds the `Team Create sync and publishing` row (see "Syncing main into Team Create and publishing").
- With two Studio windows open, call `list_roblox_studios` and pick the right one before MCP calls: the test place for script tests, the Team Create place for map and UI work.

## Git in this repo
- **Notes files** (`OWNERSHIP.md`, `STATUS.md`, `DECISIONS.md`, your own `handoffs/<name>.md`) are committed and pushed straight to `main` right after you edit them, so the other person sees them at once. This overrides any personal rule about never committing to `main`.
- **Everything else** (code, plans, configs, these rules) goes on a branch named `<your-name>/<feature>`, lowercase with dashes and exactly one slash, for example `radri/combat` or `sam/shop-ui`. Studio-only work has no branch.
- On `main`, stage files by name (`git add OWNERSHIP.md`). Never `git add -A` or `git add .` there.
- Commit your branch work before switching to `main` for a notes edit, then switch back.
- Update `main` with `git pull --rebase`. If a push to `main` is rejected, run `git pull --rebase` and push again.
- If `git pull --rebase` stops on a conflict:
  - In `STATUS.md` or `DECISIONS.md`: keep both sides' lines, delete the conflict markers, `git add <file>`, `git rebase --continue`.
  - In `OWNERSHIP.md`, if the other person changed a row you also changed, they got there first: `git rebase --skip` drops your commit. Read the table again before doing anything else.
  - In `OWNERSHIP.md`, if you changed different rows: keep their rows as they wrote them and yours as you wrote them, `git add OWNERSHIP.md`, `git rebase --continue`.
  - Anywhere else: `git rebase --abort` and ask the user.
- Merge a branch into `main` only while releasing (below). This overrides any personal rule about merging when you switch tasks.
- Push your branch at the end of every session (`git push -u origin <branch>`) so the work is backed up.
- Never force-push, delete branches or rewrite pushed history.

## Start of every session
1. Commit any branch work, `git switch main`, `git pull --rebase`.
2. Read `OWNERSHIP.md`, `STATUS.md`, your own handoff and the other person's handoff.
3. Tell the user in two or three lines: what changed, which areas are free, anything waiting for them.
4. Continuing on a branch: `git switch <branch>`, then `git merge main` so you test against the other person's latest code. A conflict here means someone edited outside their area: `git merge --abort` and ask the user.
5. Only now run `rojo serve` for your test place.

## Claiming an area
`OWNERSHIP.md` has one row per area, FREE or CLAIMED. What each row covers is written at the top of that file.
1. On `main`, `git pull --rebase`.
2. If the row is CLAIMED by the other person, don't touch it. Pick another area, or add a line under "Needs from each other" in `STATUS.md`.
3. New feature: first check that no `Feature:` row and no `src/*/<Name>` folder with that name exists. Then add the row `Feature: <Name>` in alphabetical order among the feature rows.
4. Set the row to CLAIMED with your name and today's date (YYYY-MM-DD). Change nothing else in this commit.
5. `git add OWNERSHIP.md`, commit `claim: <area>`, push. If the push is rejected, follow "Git in this repo", then check the row is still yours.
6. Start work only after the claim has pushed. For code, branch from the updated `main`: `git switch -c <your-name>/<feature>`.

## While you have an area
- Only edit files inside areas you've claimed. If you need something in the other person's area, don't edit it. Add a line under "Needs from each other" in `STATUS.md`.
- Keep changes in your area small and focused. No big refactors, renames or moves outside it.
- Commit small and often on your branch.

## Releasing an area
Do these in order. Don't tell the user it's done until the final push worked. For a Studio-only area, skip steps 1 to 3.
1. Commit, `git switch main`, `git pull --rebase`, `git switch <branch>`, `git merge main`.
2. Run the checks and fix what you broke: `rojo build default.project.json -o build.rbxl`, `selene src`, `stylua --check src`, then play-test in your test place. Don't release broken work.
3. `git switch main`, `git merge --no-ff <branch>`, `git push`. If the push is rejected, `git pull --rebase=merges` and push again.
4. Add an entry to your handoff: what you did, what works, what's left, what you tested and what you didn't.
5. Add or update lines in `STATUS.md`, and in `DECISIONS.md` if you made a design choice.
6. Set the area's row in `OWNERSHIP.md` to FREE and clear the owner and date.
7. `git add` those notes files by name, commit `release: <area>`, push to `main`. That push is the signal. The other person's Claude sees FREE on its next pull.
8. Tell the user the area is released, and remind them to tell the other person to pull.

Stopping for the day without finishing? Leave the row CLAIMED, push your branch, and write what's left in your handoff.

## Syncing main into Team Create and publishing
Only the holder of the `Team Create sync and publishing` row does this.
1. Claim the row.
2. `git switch main`, `git pull --rebase`.
3. Open the Team Create place, run `rojo serve`, connect the plugin, wait until it says it's synced, then disconnect and stop `rojo serve`.
4. Play-test in the Team Create place and check the console.
5. Publish only if the user asked to.
6. Release the row.

## Workflow for substantial work
For a new feature, a new system, anything touching several modules, or anything players could exploit, follow `docs/workflow.md`. In short: state the route, claim the areas, create the branch, send the goal to `planner`, build in small batches with `builder-sonnet` (or `builder-opus` for tricky or exploit-prone code), read the diff yourself, have `tester` run the acceptance checks in your test place, and run `code-reviewer` before releasing anything a player could abuse. The agents are defined in `.claude/agents/`. Quick answers, small one-file fixes (still claimed and on a branch) and note updates stay in the main session.

## Handoff files
- One per person at `handoffs/<name>.md`, created on their first session. You only edit your own.
- Newest entry on top, short, in the template from `handoffs/README.md`. Rewrite stale entries instead of stacking them.

## Shared notes
- `STATUS.md`: one line per item (done, doing or blocked), plus "Needs from each other". Lists merge cleanly, paragraphs don't.
- `DECISIONS.md`: one line per decision with the date and the reason. Check it before redoing a design choice.
- Pull before editing a shared file, keep edits small, push right after.

## Code structure (keep it clean, no spaghetti)
**Layout**
```
src/
  server/
    Main.server.luau     server bootstrap (Core). Never changes.
    <Feature>/init.luau  one folder per feature. init.luau is its public API.
  client/
    Main.client.luau     client bootstrap (Core). Never changes.
    <Feature>/init.luau
  shared/
    Bootstrap.luau       starts features (Core)
    Net.luau             gets remotes by name (Core)
    Util/                small helpers many features use (Core)
    <Feature>/           this feature's Config, Types and Remotes modules
```
- One feature, one PascalCase name, up to three folders: `src/server/<Feature>`, `src/client/<Feature>`, `src/shared/<Feature>`. A feature folder holds its own modules. Don't scatter one feature anywhere else.
- Every feature folder in `src/server` and `src/client` has an `init.luau` that returns the feature table. A folder without one is never started.
- `src/shared/<Feature>` holds only what both sides need. Every player can read ReplicatedStorage, so data the client must not see (drop odds, anti-cheat limits) goes in `src/server/<Feature>`.
- The only Scripts are the two bootstraps. Everything else is a ModuleScript (`.luau`). No scripts inside Workspace models or UI. Client code finds UI with `Players.LocalPlayer.PlayerGui:WaitForChild("<ScreenGuiName>")`.

**How features start**
- Each bootstrap requires every ModuleScript next to it, calls `init()` on all of them, then `start()` on all of them. Adding a feature never edits the bootstrap.
- `init()`: set up the feature's own state and, on the server, create its remotes. Don't call other features and don't yield.
- `start()`: connect events and call other features' public functions. It runs in its own thread, so it may yield.
- Never do work when a module is required.

New feature template (`src/server/<Feature>/init.luau` or `src/client/<Feature>/init.luau`):
```lua
--!strict
local Feature = {}

function Feature.init()
end

function Feature.start()
end

return Feature
```

**Modular and expandable (the priority)**
Build so that adding a feature, item or enemy means adding something, not rewriting something.
- **Data-driven content.** Items, enemies, abilities, shop entries, levels and tuning values are data in config modules (for example `src/shared/Inventory/Items.luau`). Adding one is a new data entry. The logic that uses them doesn't change.
- **Public API per feature.** Other features call the functions in a feature's `init.luau`, never the files inside its folder.
- **Loose coupling.** Features talk through those public functions or through signals, not by reading each other's state. A feature should be removable without editing the others. If two features need each other, one of them uses a signal instead of a require.
- **Extend, don't edit.** Prefer small registries (a table of handlers keyed by name) over growing `if/elseif` chains. When a second case shows up, make the pattern; don't copy the first one.
- **Types as contracts.** Types for a feature's data and remote payloads live in `src/shared/<Feature>/Types.luau`, so both sides agree and changes show up as type errors.
- Don't over-build either. Make the seam where a second use is likely, not for every imaginable future.

**Remotes**
- Get remotes with `Net.event("<Feature>/<Action>")` or `Net.func("<Feature>/<Action>")` from `src/shared/Net.luau`. Keep each feature's remote names as constants in `src/shared/<Feature>/Remotes.luau`.
- The server feature asks for its remotes in `init()`, which creates them. Never place RemoteEvents in Studio by hand.
- The server validates every argument (type, range, ownership), limits how often a player can fire each remote, and never trusts the client. Clients only send requests; the server decides.

**Code**
- Strict Luau: `--!strict` at the top of every file, and types for function parameters, returns and shared data.
- One module, one job. If a module needs "and" to describe it, split it. Aim for functions under about 40 lines and modules under about 300.
- Dependencies point one way: bootstrap -> feature modules -> shared. No circular requires.
- No globals: never use `_G` or the `shared` global table. Pass dependencies in or `require` them.
- Magic numbers and strings go in a config module with a name, not inline.
- Clean up after yourself: disconnect connections, destroy temporary instances, handle `Players.PlayerRemoving`.
- Handle real edge cases (nil values, a player leaving mid-action, a remote fired too often). Use `task.wait`, `task.spawn`, `task.delay`, never `wait`, `spawn` or `delay`.
- Names say what things are (`playerCooldowns`, `applyDamage`). No abbreviations, no leftover debug prints, no commented-out code.
- Reuse before adding: search `src/` for an existing module before writing a new one. Smallest change that solves the task, and don't tidy things outside your area.
- Format the files you changed with `stylua <files>`. `selene src` must show no errors or warnings.
- Match the conventions already in the project, but don't copy a mess.

**Before you release an area**
- Re-read your own diff. Remove dead code, duplicated logic and unused requires.
- Play-test in your test place, check the console for errors and warnings, and test the edge cases (rejoin, two players, spamming the action).
- Say plainly in your handoff what you tested and what you didn't.

## Never
- Force-push, delete branches or rewrite pushed history.
- Edit an area the other person has claimed, or change their row in `OWNERSHIP.md`.
- Edit scripts in Studio or through the Studio MCP.
- Run `rojo serve` before pulling, or connect Rojo to the Team Create place without holding the `Team Create sync and publishing` row.
- Leave known mess behind. If you spot a smell outside your area, add a line to `STATUS.md` instead of ignoring it or fixing it yourself.
- Publish the game unless the user says to.
