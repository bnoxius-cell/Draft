# Workflow for work that matters

Both Claudes follow this. It sits on top of the claim system in `CLAUDE.md`.

## When to use it
- **Do it yourself in the main session:** quick answers, small fixes in one file (still claimed and on a branch), notes and ownership updates, git chores, play-testing a change you just made.
- **Use the full loop below:** a new feature, a new system, anything touching several modules, anything players could exploit (remotes, data stores, purchases), or a bug you can't explain.

## Roles (agents live in `.claude/agents/`)
| Role | Model | Job |
|---|---|---|
| Main session (orchestrator) | whatever you run | Routes the task, talks to the user, relays between agents, reads every diff, merges, keeps notes and ownership |
| `planner` | Opus | Investigates read-only and writes the plan to `plans/<topic>-plan.md` |
| `builder-sonnet` | Sonnet | Default builder for a clear plan batch |
| `builder-opus` | Opus | Tricky logic, server/client timing, data handling, security-sensitive code, or a batch that failed on Sonnet |
| `tester` | Sonnet | Runs the plan's acceptance checks in Studio, reports Pass or Fail with repro. Never fixes |
| `code-reviewer` | Opus | Read-only review before merging anything a player could abuse, or when asked |

Agents never talk to each other. Every report comes back to the main session, which passes it on.

Use only these agents in this repo, even if your personal setup has others (for example `builder-haiku` or `Explore`). Personal agents don't know these rules.

## The loop
1. **Route.** State it in one line before starting ("Route: planner -> builder-sonnet -> tester").
2. **Claim.** Claim the areas the work needs in `OWNERSHIP.md` (see `CLAUDE.md`).
3. **Branch.** Create the branch `<your-name>/<feature>` from the updated `main`. The plan and all builds go on it.
4. **Plan.** For anything bigger than a small fix, send the goal to `planner`. It writes `plans/<topic>-plan.md` and returns open decisions and any extra areas to claim. Claim those areas, ask the user about the open decisions, record the answers in the plan, and commit the plan on the branch before any builder starts. Builders stop if they find uncommitted changes.
5. **Build.** One batch per builder spawn, on the branch you created. Start on the cheaper builder when the plan is exact. Use `builder-opus` first for exploit-prone or tricky code.
6. **Read the diff.** The main session reads the real diff (not only the report) before accepting. Quality problems go back to the builder as a numbered list.
7. **Test.** Rojo must be serving the branch into your test place, connected and synced. Then spawn `tester` with that batch's acceptance checks.
8. **Fail.** Slip (typo, missed case): send the tester's findings back to a builder. Real difficulty (wrong logic, timing bug, a fix that broke something else): go to `builder-opus`. Plan was wrong: back to `planner`. Two failed rounds on the same batch at `builder-opus`: stop and bring it to the user.
9. **Pass.** Run `code-reviewer` if the work is security-sensitive, then release the area as described in `CLAUDE.md`.

## Writing a brief
Keep it short and make it stand alone:
- What to do: plan file and batch, or a numbered list with file paths and expected behavior.
- Branch name, and the one area the agent may touch.
- Decisions already made that the plan doesn't record yet.
- For fix rounds: the tester's findings verbatim.
- Known traps and what not to touch.
- "Follow `CLAUDE.md`. Write clean, modular code. Learn conventions from nearby files but don't copy bad patterns. Scripts only as files in `src/`. Checks: `rojo build default.project.json -o build.rbxl`, `selene src`, `stylua --check` on the files you changed."
- Ask the report to list files changed, what was reused, what was verified and not, and any smell left alone.
Point at files instead of pasting them.

## Quality comes before cost
- Don't accept cheap output just because it passed once: read the diff and run the tester.
- A messy result (copied bad patterns, duplicated logic, "done" without running it) goes back or up a rung. Don't merge it to save a round.
- Unsure whether a batch is safe on the cheaper builder? Pick the stronger one.
- Save effort by tighter briefs and cheaper building, never by weaker checking.

## Routing notes
Add one line when something stepped up or a cheaper builder clearly would have done. Keep to about five lines.
- (none yet)
