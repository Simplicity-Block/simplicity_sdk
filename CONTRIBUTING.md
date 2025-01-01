# Contributing to Simplicity SDK

First off, thank you for considering contributing to **Simplicity SDK**! This project aims to simplify interaction with smart contracts written in Simply Lang and deployed on the Simplicity blockchain.

## Prerequisites

Before you begin contributing, please ensure you have a good understanding of:

1. **Simplicity Blockchain**
   * Review the [Simplicity Block documentation](https://simplicity-block.vercel.app/)
   * Understand the basic concepts of the blockchain architecture
   * Familiarize yourself with transaction signing and validation
   * Learn about block structure and consensus mechanisms
2. **Simply Lang**
   * Study the [Simply Lang specification](https://simply-lang.vercel.app/)
   * Understand the contract syntax and structure
   * Learn about supported data types and operations
   * Practice writing and deploying simple contracts
3. **Development Environment**
   * Flutter SDK (latest stable version)
   * Dart SDK (>=2.17.0)
   * Your favorite IDE (VS Code, Android Studio, or IntelliJ IDEA)
   * Git for version control

## Getting Started

1. **Fork the Repository**
   ```bash
   git clone https://github.com/affanshaikhsurab/simplicity_sdk.git
   cd simplicity_sdk
   flutter pub get
   ```
2. **Set Up Development Environment**
   ```bash
   # Create a new branch for your feature
   git checkout -b feature/your-feature-name

   # Or for bug fixes
   git checkout -b fix/your-fix-name
   ```

## Development Guidelines

### Code Style

1. **Dart Style Guide**
   * Follow the [official Dart style guide](https://dart.dev/guides/language/effective-dart/style)
   * Use `dart format` to format your code
   * Maintain a consistent code style with the existing codebase
2. **Documentation**
   * Document all public APIs using dartdoc comments
   * Include examples in documentation where appropriate
   * Update README.md if adding new features

### Testing

1. **Unit Tests**
   ```bash
   # Run tests
   flutter test

   # Check code coverage
   flutter test --coverage
   ```
2. **Integration Tests**
   * Write integration tests for new features
   * Ensure backward compatibility
   * Test with different Simply Lang contract versions

### Smart Contract Best Practices

1. **Contract Interaction**
   * Always validate input parameters
   * Handle contract call failures gracefully
   * Implement proper error handling and messages
   * Add proper transaction signing validation
2. **Security Considerations**
   * Never expose private keys in logs or error messages
   * Implement proper input sanitization
   * Add validation for contract addresses
   * Follow secure ECDSA signing practices

## Pull Request Process

1. **Before Submitting**
   * Update documentation for new features
   * Add or update tests as needed
   * Run the test suite and ensure all tests pass
   * Update the CHANGELOG.md following [Keep a Changelog](https://keepachangelog.com/)
2. **Pull Request Format**
   ```markdown
   ## Description
   Clear description of the changes and motivation

   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Breaking change
   - [ ] Documentation update

   ## Testing Instructions
   Steps to test the changes

   ## Checklist
   - [ ] Tests added/updated
   - [ ] Documentation updated
   - [ ] CHANGELOG.md updated
   - [ ] Verified Simply Lang compatibility
   ```
3. **Code Review Process**
   * All PRs require at least one reviewer
   * Address review comments promptly
   * Keep the PR focused on a single feature/fix

## Contract Development Guidelines

1. **Simply Lang Contracts**
   ```simply
   // Follow this format for contract examples
   contract example with parameter does
       function_name takes parameter does
           // Implementation
       .
   .
   ```
2. **Testing Contracts**
   * Include test contracts in `/test/contracts`
   * Test different contract scenarios
   * Verify parameter handling
   * Check error conditions

## Release Process

1. **Version Updates**
   * Follow semantic versioning
   * Update version in pubspec.yaml
   * Update CHANGELOG.md
   * Create a GitHub release
2. **Publishing**
   ```bash
   # Dry run
   flutter pub publish --dry-run

   # Publish
   flutter pub publish
   ```

## Community and Communication

* Use [GitHub Issues](https://github.com/your-repo/simplicity_sdk/issues) for bug reports and feature requests
* Join our [Discord channel](https://discord.gg/your-channel) for discussions
* Follow our [Twitter](https://twitter.com/your-handle) for updates
* Read our [blog](https://your-blog.com/) for detailed articles and tutorials

## Additional Resources

1. **Simply Lang Resources**
   * [Language Documentation](https://simply-lang.vercel.app/#)
   * [Best Practices Guide](https://best-practices.simply-lang.com/)
2. **Simplicity Block Resources**
   * [Network Documentation](https://docs.simplicity-block.com/)
   * [Transaction Guide](https://docs.simplicity-block.com/transactions)
   * [API Reference](https://api.simplicity-block.com/)

## Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](https://chatgpt.com/c/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

## License

By contributing to **Simplicity SDK**, you agree that your contributions will be licensed under its MIT License.
