---
name: frenum
description: Start a specification-first project, adopt or resume a repository, and operate the Frenum repository-native human-AI development harness.
---

# Frenum

Use Frenum when starting a project, adopting an existing repository, resuming work from a cold session, proving a bounded task, or inspecting its software-factory state.

## Required policy

Load the official Ponytail skill at `full` before architecture or code changes. Do not replace it with a copied summary.

## Entry points

- New product: `frenum init <repo> --workflow new-product --objective "..."`. Remain in discovery/specification until human approval.
- New task-only repository: `frenum init <repo> --objective "..."`.
- Existing repository: `frenum adopt <repo>` first; run again with `--write` only after the human accepts the discovery report.
- Existing legacy spine: `frenum migrate <repo>` first, then `--write`. Migration preserves every legacy file.
- Resume: read `.frenum/KICKOFF.md`, then the active task in `.frenum/project.json`.
- Connect cold coding-agent sessions: inspect `frenum agent connect <repo>` first, then use `--write` only with human approval.

If `frenum` is not on `PATH`, run `node <frenum-kit>/tools/frenum.mjs`.

## Session contract

Before editing, report `state → evidence → blocker → next action`. Inspect only the relevant graph neighborhood, decisions, and proof. Search the repository before adding anything.

Obey the workflow phase instruction in `KICKOFF.md`. During discovery, specification, and planning, do not write product implementation code.

## New-product workflow

1. Interview the human about users, outcomes, constraints, non-goals, trust boundaries, risks, success criteria, and unknowns.
2. Record consequential assumptions, decisions, and sourced knowledge through `frenum record` while filling `SPEC.md`.
3. Give every functional, non-functional, and acceptance requirement a stable `FR-*`, `NFR-*`, or `AC-*` identifier.
4. Run `frenum spec check <repo>`. Show the specification and stop for explicit human approval; never approve it on the human's behalf.
5. After approval, record it with `frenum spec approve <repo> --human NAME --reason "..."`.
6. Create bounded tasks using approved `--requirement` identifiers and at least one executable `--gate` per task.
7. Run `frenum plan check <repo>`, show generated `.frenum/PLAN.md`, and stop for explicit human approval.
8. Record approval with `frenum plan approve <repo> --human NAME --reason "..."`, then implement only the activated task.

Create one bounded task. Every mandatory check must pass against the current source hash; pending, skipped, failed, missing, and stale proof block completion. Medium risk and above requires independent review.

Use `frenum record knowledge|decision|assumption|invariant` for durable context and provenance. Do not leave a binding decision or discovered constraint only in chat.

Decision and knowledge records require `--title` and `--text`; assumptions and invariants require `--text`. Add `--source` whenever provenance is known.

Non-low-risk tasks automatically receive an `independent-review` gate. A separate human approves it only after checking the diff and proof:

```bash
frenum control approve <repo> <task-id> --gate independent-review --human <name> --reason "..."
```

Checkpoint before handing off:

```bash
frenum checkpoint <repo>
```

The generated kickoff and dashboard are read-only projections of `project.json`. Raw traces stay local and secrets are redacted. Propose cleanup and learned rules; never delete code or promote harness rules silently.
