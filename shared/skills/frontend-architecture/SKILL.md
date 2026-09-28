# Frontend Architecture Skill

- Optimize for long-term changeability.
- Organize around product/domain boundaries when appropriate.
- Keep dependencies directional and obvious.
- Separate UI, orchestration, domain logic, and external I/O where complexity warrants it.
- Avoid global state for data with a natural local owner.
- Treat server state with a server-state library rather than duplicating it into client stores.
- Keep shared modules genuinely generic.
- Introduce abstractions after repeated patterns become clear.
- For micro-frontends, define ownership, contracts, deployment boundaries, shared dependencies, and failure isolation explicitly.
