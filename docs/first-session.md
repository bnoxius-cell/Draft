# First session on a new machine

Do this once per person per machine, in order. Steps marked (user) need the person at the keyboard; ask them and wait.

1. **Access (user).** The owner adds you as a collaborator on the GitHub repo and gives you edit access to the place through Team Create (on Roblox you need to be friends for a personal game). Accept both invites.
2. **Git.** Check `git --version` works and that `git config user.name` and `git config user.email` are set. Make sure the user can push to GitHub (for example `gh auth status`). Clone the repo and open Claude Code in the repo folder.
3. **Your name.** Ask the user for their GitHub username. Use it in lowercase as `<name>` from now on.
   - Create `CLAUDE.local.md` in the repo root with one line: `The user here is <name>.` Git ignores this file.
   - If `handoffs/<name>.md` doesn't exist, create it from the template in `handoffs/README.md` with a first entry for today. Then `git add handoffs/<name>.md`, commit `handoff: add <name>`, `git pull --rebase`, push to `main`.
4. **Tools.** If neither `rokit --version` nor `aftman --version` works, ask the user to install Rokit (https://github.com/rojo-rbx/rokit, follow its README). In the repo run `rokit install` (or `aftman install` if they use Aftman). If it stops because a tool isn't trusted, run `rokit trust <tool>` for each one it names, then install again. Check `rojo --version` prints 7.7.1, `selene --version` 0.32.0, `stylua --version` 2.6.0.
5. **Rojo plugin.** In the repo run `rojo plugin install`, so the plugin matches the pinned Rojo. If the Rojo plugin from the Creator Store is also installed, the user removes it in Studio so there's only one. Restart Studio.
6. **Studio MCP.** The server must be named exactly `Roblox_Studio`. The rules in `.claude/settings.json` only match that name.
   - Check with `claude mcp get Roblox_Studio`. If it's missing, on Windows add it from PowerShell (not Git Bash, which turns `/c` into a path):
     `claude mcp add --transport stdio Roblox_Studio -- "cmd.exe" "/c" "cd /d %LOCALAPPDATA%\Roblox && .\mcp.bat"`
     On macOS, follow Roblox's docs for the Studio MCP command and keep the name `Roblox_Studio`.
   - (user) Restart Claude Code. Run `/mcp` and check `Roblox_Studio` is connected while Studio is open.
7. **Test place (user).** Open the Team Create place in Studio. File > Save to File As, save as `test-place.rbxl` in the repo root. Open that file, run `rojo serve` in the repo and click Connect in the Rojo plugin. Check that ServerScriptService > Server > Main exists. Play-test once and check the console has no errors.
8. Tell the user setup is done. From now on, follow "Start of every session" in `CLAUDE.md`.
