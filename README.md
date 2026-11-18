# stamp

**The CRUD engine for products and pens.** Every product and pen in the estate is
created, audited, reorganized, renamed, and swept by this forge — and stamped
with the maximal Bun scaffold (bunfig + validate/test/typecheck gates).

> Renamed from `eidos` (2026-11-18). The forge that "stamps every product" is
> now literally named `stamp`.

## The CRUD surface

| Operation | Command | What it does |
|---|---|---|
| **Create** | `bin/make-pen.ts --pen <name>` | instantiate a new pen from the scaffold |
| **Create** | `bin/apply.ts` | bring an existing pen repo into the thin-coordinator scaffold |
| **Read** | `bin/audit-pen.ts` | automated five-shape audit of a pen (or all pens) |
| **Read** | `bin/manifest-gen.ts` / `manifest-sync.ts` | regenerate + verify the bin manifest |
| **Update** | `bin/reorganize-pen.ts` | force a pen into the five-shape layout (non-destructive, hardlink snapshot rollback) |
| **Update** | `bin/register-namespace.ts` | register a product namespace |
| **Update** | `bin/readme-gen.ts` | regenerate pen READMEs |
| **Update** | `bin/emit-ast-validator.ts` | emit an ast-grep validator into a target |
| **Delete/ops** | `bin/push-sweep.ts` | background sweeper: commit+push every repo |
| **Ops** | `bin/exec.ts` | run a shell command across every product of a pen |
| **Ops** | `bin/lint-paths.ts` / `ssot-sync.ts` / `watch-procs.sh` | ghost-path lease, SSOT sync, process watch |

## The Bun scaffold (what every product gets stamped with)

`bunfig.toml` + the maximal script set (`validate`, `typecheck`, `test`,
`test:coverage`, `lint`) + drop-in wiring. Applied per project via
`src/apply-stamp.ts` (`--target <dir>`, `--dry-run`, `--llm`).

## Layout

```
stamp/
├── bin/          the CRUD command surface (CLI)
├── src/          apply-stamp, stamp-runtime, stamp-bridge, scaffold-services
├── dropin/       lib drop-ins (agent-relaunch, model-matrix, tdd-gate, ...)
├── plugin/       reactive-error, rename, delendai integration
├── mcp/          MCP server
└── tests/        bun test
```

## Rename with lapidary

Re-renaming this product (or any product) is a two-step lapidary pass:
content (`word: old => new` rules) then filenames (`git mv`), then repoint the
git remote. Full rename is recorded in `.lapidary-undo.jsonl`.