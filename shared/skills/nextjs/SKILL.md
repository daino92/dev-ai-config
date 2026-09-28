# Next.js Skill

- Respect server/client boundaries.
- Keep secrets and privileged data on the server.
- Prefer server-side data access when it reduces client complexity.
- Use route handlers for HTTP boundaries, not as unnecessary internal proxies.
- Handle caching, revalidation, and dynamic rendering intentionally.
- Keep metadata, loading, error, and not-found behavior explicit.
- Avoid hydration mismatches and browser-only APIs during server rendering.
- Preserve streaming and Suspense benefits where appropriate.
- Validate environment variables and external payloads.
