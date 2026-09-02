# Frenum

Frenum is an open-source, agent-agnostic development harness for human–AI software work:

```text
idea → discovery → specification → plan → code → proof → checkpoint
```

It gives a coding agent durable project memory, explicit phase boundaries, traceable requirements, fresh proof, and an exact next action. It runs locally on Node.js 18+ with no package dependencies. Ponytail `full` is mandatory.

## Fastest start: paste this into your coding agent

Replace the goal in the first line, then paste the complete prompt into a coding session opened inside your new project repository:

```text
Set up and use Frenum for this repository. My project goal is: "REPLACE THIS WITH WHAT I WANT TO BUILD."

1. Check whether the `frenum` command is available. If it is missing, ensure Frenum CLI is linked globally.
2. Load the installed Frenum skill and the official Ponytail skill at full.
3. If this repository already contains implementation code, run `frenum adopt .` read-only, show me the discovery report, and wait for my approval before running `frenum adopt . --write`.
4. If this is a new project, run `frenum init . --workflow new-product --objective "<the project goal I gave above>"` using my actual goal, not the angle-bracket placeholder.
5. Run `frenum agent connect . --write` so future coding sessions load the repository contract.
6. Read `.frenum/KICKOFF.md` and report: state → evidence → blocker → next action.
7. For a new product, remain in discovery/specification mode. Interview me about users, outcomes, constraints, non-goals, trust boundaries, risks, success criteria, and open questions. Record durable assumptions, decisions, and sourced knowledge through Frenum. Fill SPEC.md with stable FR-*, NFR-*, and AC-* identifiers. Do not write product implementation code.
8. Run `frenum spec check .`. Show me the specification and wait for my explicit approval. Never approve on my behalf.
9. After I approve, record it with `frenum spec approve . --human "MY NAME" --reason "Specification reviewed"`.
10. Create bounded implementation tasks. Every task must reference approved requirement IDs with `--requirement` and include an executable `--gate`. Run `frenum plan check .`, show me `.frenum/PLAN.md`, and wait for my explicit plan approval.
11. After I approve the plan, run `frenum plan approve . --human "MY NAME"`. Implement only the active task, run its gates, obtain independent human review for medium-risk or higher work, and checkpoint before stopping.

Never claim a gate passed without running it. Never code while the Frenum phase instruction prohibits implementation. Never leave a binding decision only in chat.
```

For an existing project, use this shorter prompt:

```text
Use Frenum to adopt this existing repository. Load Frenum and Ponytail full. Run `frenum adopt .` read-only and show me the discovered languages, commands, git state, and legacy Frenum status. Do not write anything until I approve adoption. After approval, run `frenum adopt . --write`, then `frenum agent connect . --write`, read `.frenum/KICKOFF.md`, index the repository, record confirmed invariants and important knowledge, and propose one bounded task with executable proof. Report state → evidence → blocker → next action before editing code.
```

For a later cold session:

```text
Resume this repository with Frenum. Load Frenum and Ponytail full, read `.frenum/KICKOFF.md`, verify the current source and proof state, obey the current phase instruction, and continue only the active task. Record durable discoveries and run `frenum checkpoint .` before stopping.
```

## Install manually

```bash
npm link
```

## New-product workflow

Initialize a specification-first project:

```bash
frenum init . --workflow new-product --objective "Build my application"
frenum agent connect . --write
```

Frenum creates:

- `SPEC.md` — the human-readable product specification;
- `.frenum/project.json` — canonical workflow, task, knowledge, approval, and proof state;
- `.frenum/KICKOFF.md` — the cold-session handoff;
- `.frenum/PLAN.md` — a generated requirement-to-task projection;
- `.frenum/dashboard.html` — local status and redacted trace view;
- `.frenum/index/graph.html` — searchable graphical code index.

During discovery, the coding agent interviews the human and updates `SPEC.md`. It records durable context instead of leaving it in chat:

```bash
frenum record assumption . --id A-1 --text "Users authenticate via OAuth" --source "human interview"
frenum record decision . --id ADR-1 --title "Database choice" --text "Use SQLite for local persistence" --source "human approval"
frenum record knowledge . --id K-1 --title "Business rule" --text "Accounts must have verified email" --source "domain interview"
```

The specification must contain `FR-*`, `NFR-*`, and `AC-*` identifiers. Check it, then record explicit human approval:

```bash
frenum spec check .
frenum spec approve . --human user --reason "Scope and acceptance criteria reviewed"
```

Create tasks that trace back to approved requirements:

```bash
frenum task add . \
  --id T-1 \
  --outcome "User login flow implemented" \
  --risk medium \
  --requirement FR-1 \
  --requirement NFR-1 \
  --requirement AC-1 \
  --gate 'tests:npm test'

frenum plan check .
frenum plan approve . --human user --reason "Slices and proof reviewed"
```

Frenum will not activate implementation work until the specification and plan pass their checks and receive human approval.

## Build and prove

```bash
frenum status .
frenum gate . T-1
frenum control approve . T-1 \
  --gate independent-review \
  --human reviewer-name \
  --reason "Reviewed the change and current proof"
frenum task complete . --id T-1
frenum checkpoint .
```

## Useful commands

```bash
frenum workflow status .               # current workflow and phase
frenum spec status .                   # draft, checked, approved, or stale
frenum plan status .                   # traceability and approval state
frenum plan reopen . --human NAME --reason "Scope changed"  # reopen after active work ends
frenum index .                         # refresh the graphical code index
frenum dashboard .                     # regenerate the local control view
frenum trace . --event work.started    # append a redacted local trace
frenum control pause . T-1             # human control action
frenum cleanup .                       # propose stale-code review; delete nothing
frenum learn propose . --rule "..."    # propose a harness rule; never self-promote
```

MIT.
