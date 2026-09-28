# Shared Agent Instructions

## Working style
- Inspect the existing codebase before structural changes.
- Prefer the smallest correct change over rewrites.
- Preserve established conventions unless there is a concrete reason to change them.
- State assumptions when requirements are ambiguous.
- Do not introduce dependencies without clear benefit.
- Keep changes reviewable and scoped.

## Engineering quality
- Favor explicit, type-safe interfaces.
- Keep component and module boundaries clear.
- Avoid premature abstractions and duplicated logic.
- Treat accessibility, performance, error states, loading states, and empty states as production requirements.
- Prefer predictable state ownership and data flow.
- Add or update tests when behavior changes.
- Run available lint, typecheck, test, and build commands before declaring work complete.

## Git
- Follow GitFlow.
- Create feature branches from `develop`.
- Use conventional commits.
- Keep `main` and `develop` protected from direct pushes.
