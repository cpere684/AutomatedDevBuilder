# Contributing

Thank you for contributing! This project follows a simple Git workflow tailored for students and small teams.

Branching and PR workflow
- Keep main branch stable. Use feature branches for new work.
- Branch naming:
  - feature/yourname-short-desc
  - fix/yourname-short-desc
  - docs/yourname-short-desc
- Create a branch, make changes, commit, push, and open a Pull Request (PR) against main.

Suggested commands (copy/paste)
- git fetch origin
- git switch -c feature/yourname-short-desc
- # make edits
- git add .
- git commit -m "Short: what and why"
- git push -u origin feature/yourname-short-desc
- Open PR on GitHub and request reviewers.

PR checklist (reviewers)
- [ ] Code builds and runs (if applicable)
- [ ] Scripts are executable if needed
- [ ] Tests (if any) pass locally
- [ ] Documentation updated (README/USAGE/INSTALL as needed)
- [ ] Small PRs preferred (easier to review)

Coding conventions and tips
- Use meaningful commit messages.
- Small commits are easier to review.
- If you need help with git, see the included GIT-CHEATSHEET.md in the repo.

License
- By contributing you agree to the project license (MIT). See LICENSE.