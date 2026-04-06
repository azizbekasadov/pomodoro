# Contributing

Thank you for your interest in contributing to this project.

This repository is intended to be both a useful app and a learning-oriented open-source codebase focused on:

- modular architecture
- Combine
- TDD
- SwiftUI + MVVM
- UI-independent business logic

Please keep that goal in mind when contributing.

---

## Ground Rules

Before contributing, please make sure your changes align with these principles:

1. **Keep business logic framework-agnostic**
   - Core logic should not depend on SwiftUI, UIKit, Core Data, ActivityKit, or UserNotifications.

2. **Prefer protocols at boundaries**
   - Infrastructure and platform integrations should be accessed through abstractions.

3. **Use TDD where practical**
   - Write tests first or alongside implementation.
   - New behavior should usually come with tests.

4. **Use Combine intentionally**
   - Prefer clear, composable publisher pipelines over ad hoc state mutations.
   - Avoid unnecessary complexity.

5. **Keep modules focused**
   - Avoid dumping unrelated code into broad utility folders.
   - Respect module boundaries.

---

## Ways to Contribute

You can contribute by:

- reporting bugs
- suggesting improvements
- improving documentation
- adding tests
- refining architecture
- implementing planned features
- improving accessibility and usability

---

## Before You Start

For larger changes, please open an issue or discussion first so we can align on:

- scope
- architecture
- naming
- module placement
- testing strategy

This helps avoid wasted effort and keeps the project coherent.

---

## Development Guidelines

### Architecture

Please preserve the intended dependency direction:

- UI depends on application/domain abstractions
- persistence depends on domain abstractions
- platform services depend on domain abstractions
- domain should not depend on UI or infrastructure frameworks

### File Organization

Prefer feature-oriented organization in the UI layer and responsibility-based organization in lower layers.

### Naming

Try to use clear suffixes consistently, such as:

- `UseCase`
- `Repository`
- `Store`
- `Mapper`
- `ViewModel`
- `ViewData`
- `Spy`
- `Fake`
- `Stub`

### Keep PRs Focused

Small, focused pull requests are much easier to review than large mixed changes.

Prefer:
- one feature
- one refactor
- one bug fix
- one documentation improvement

per pull request when possible.

---

## Testing Expectations

Please include tests for meaningful changes.

Examples:

- domain rule changes should include domain tests
- use case changes should include use case tests
- persistence changes should include repository/integration tests
- pagination/search logic should include view model or application tests

Test code should be:
- deterministic
- readable
- isolated
- explicit in intent

Avoid flaky timing-dependent tests when a test clock or scheduler can be used instead.

---

## Branches and Commits

### Branch naming

Suggested examples:

- `feature/add-session-search`
- `fix/pagination-duplicate-load`
- `refactor/timer-state-machine`
- `docs/update-readme`

### Commit messages

Please use clear commit messages.

Examples:

- `Add restore active pomodoro use case`
- `Fix duplicate page load in history view model`
- `Document module boundaries`

---

## Pull Request Checklist

Before opening a pull request, please check that:

- the code builds
- tests pass
- new behavior is covered by tests where appropriate
- documentation is updated if needed
- module boundaries are respected
- no unrelated changes are included

---

## Issue Reports

When reporting a bug, please include:

- expected behavior
- actual behavior
- steps to reproduce
- device/simulator information
- iOS version
- screenshots or logs if helpful

---

## Feature Requests

Feature requests are welcome.

Please describe:

- the problem you are trying to solve
- the proposed behavior
- possible architectural impact
- whether you would like to implement it yourself

---

## Code Style

General expectations:

- prefer clarity over cleverness
- keep files focused
- avoid unnecessary abstractions
- avoid massive view models
- avoid framework leakage into the domain
- keep public APIs intentional and minimal

If formatting or linting tools are added later, please follow them.

---

## Documentation Contributions

Documentation improvements are valuable and strongly encouraged.

Good examples include:

- architecture explanations
- diagrams
- onboarding notes
- testing explanations
- ADRs
- README improvements

---

## Questions

If something is unclear, open an issue or discussion and ask.

Constructive questions are always welcome.

---

## Code of Conduct

By participating in this project, you agree to follow the [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).
