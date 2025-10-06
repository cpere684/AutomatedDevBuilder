# Contributing to AutomatedDevBuilder

Thank you for your interest in contributing! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Issues

- Use the GitHub issue tracker
- Describe the issue clearly
- Include steps to reproduce
- Mention your environment (OS, Docker version, etc.)

### Suggesting Enhancements

- Open an issue with the "enhancement" label
- Describe the feature and use case
- Explain why it would be useful

### Code Contributions

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow existing code style
   - Update documentation as needed
   - Test your changes

4. **Commit your changes**
   ```bash
   git commit -m "Add: description of your changes"
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request**

## Guidelines

### Ansible Playbooks

- Use descriptive task names
- Include comments for complex logic
- Test on a clean environment
- Follow Ansible best practices

### Docker Configuration

- Keep images minimal
- Document any new dependencies
- Test build process
- Consider security implications

### Documentation

- Update README.md for user-facing changes
- Add inline comments for complex code
- Update example configurations if needed

### Package Additions

When adding new packages:
- Group them in appropriate categories
- Test installation
- Document purpose in comments
- Consider cross-platform compatibility

## Code Style

### YAML Files
- Use 2 spaces for indentation
- Keep lines under 120 characters
- Use meaningful variable names

### Shell Scripts
- Include shebang (`#!/bin/bash`)
- Add error handling (`set -e`)
- Use descriptive comments
- Follow shellcheck recommendations

## Testing

Before submitting:
1. Test Docker build: `docker-compose build`
2. Test container startup: `docker-compose up -d`
3. Test Ansible playbook: `make ansible-run`
4. Verify documentation accuracy

## Questions?

Open an issue for any questions or clarifications.
