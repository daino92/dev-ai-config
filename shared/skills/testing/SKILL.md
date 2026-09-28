# Testing Skill

Aim for confidence, not test count.

- Test behavior and public contracts rather than implementation details.
- Prefer realistic inputs and user-visible outcomes.
- Keep mocks at external boundaries.
- Cover important failure paths and edge cases.
- In Playwright, prefer role-, label-, and test-id-based locators over brittle CSS/XPath.
- Avoid arbitrary sleeps; wait on observable application state.
- Keep tests isolated and deterministic.
- Use reusable fixtures for authentication and environment setup.
