# Examples Directory

This directory contains example configurations for different development scenarios.

## Available Examples

1. **[Python Web Developer](python-web-developer.md)**: Configuration for Django, Flask, and FastAPI development
2. **[Java Enterprise Developer](java-developer.md)**: Configuration for Spring Boot, Maven, and Gradle projects

## Using Examples

Each example includes:
- Recommended `packages.yml` configuration
- Additional setup steps
- Common commands and workflows
- Project structure suggestions

To use an example:

1. Review the example configuration
2. Copy the recommended `packages.yml` content to `ansible/vars/packages.yml`
3. Customize as needed for your organization
4. Run the setup: `make setup`

## Contributing Examples

Have a configuration that works well for your team? Consider contributing it!

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

## Creating Your Own

You can create custom configurations by:
1. Starting with an existing example
2. Modifying package lists in `ansible/vars/packages.yml`
3. Testing thoroughly
4. Documenting your setup

Feel free to mix and match packages from different examples!
