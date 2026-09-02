# Agent adapters

Frenum state is agent-agnostic. Codex and Claude Code use the same repository contract and CLI.

| Need | Codex | Claude Code |
|---|---|---|
| Load policy | invoke installed `ponytail` and `frenum` skills | invoke installed `ponytail` and `frenum` skills |
| Resume | read `.frenum/KICKOFF.md` | read `.frenum/KICKOFF.md` |
| Connect repository | `frenum agent connect . --codex --write` | `frenum agent connect . --claude --write` |
| Run Frenum | `frenum …` or `node <kit>/tools/frenum.mjs …` | `frenum …` or `node <kit>/tools/frenum.mjs …` |
| Independent check | fresh context or another agent; record human approval for manual proof | fresh context or another agent; record human approval for manual proof |
| Parallel writing | isolated git worktree with declared file ownership | isolated git worktree with declared file ownership |

Other agents need only be able to read JSON/Markdown, run shell commands, and follow the contract in `.frenum/KICKOFF.md`. Add an adapter only after a real incompatibility is observed.
