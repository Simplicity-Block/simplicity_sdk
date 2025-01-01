# Simplicity SDK for Flutter

This is the **official SDK** for interacting with the **Simplicity Blockchain**, designed specifically for developers using **Flutter**. The SDK provides an effortless way to deploy smart contracts and interact with their functions, all while abstracting complexities like signature management.

The SDK is tailored to support smart contracts written in **Simply-lang**, a simple and developer-friendly programming language for the Simplicity Blockchain. With this package, you can focus on building innovative blockchain solutions without worrying about low-level details.

Learn more about Simply-lang and Simplicity Blockchain here:
[Simply-Lang](https://simply-lang.vercel.app/)
[Simplicity Block](https://simplicity-block.vercel.app/)

## Features

- 🚀 Easy contract deployment
- 🔄 Simple function calls
- 🔐 Automatic signature handling
- 🔑 Public key derivation
- ⚡ Async/await support
- 🛡️ Comprehensive error handling

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  simplicity_sdk: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### Initialize the SDK

```dart
import 'package:simplicity_sdk/simplicity_sdk.dart';

final sdk = SmartContractSDK();
```

### Deploy a Contract

```dart
try {
  final deploymentResult = await sdk.deployContract(
    privateKey: 'your_private_key',
    contractName: 'MyWallet',
    contractCode: '''
      contract wallet with amount, address does
        deposit takes amount does
          save balance is balance + amount
          return balance
        .
      .
    ''',
  );
  
  print('Contract deployed at: ${deploymentResult.contractAddress}');
} on SmartContractException catch (e) {
  print('Deployment failed: $e');
}
```

### Call Contract Functions

```dart
try {
  final callResult = await sdk.callContract(
    privateKey: 'your_private_key',
    contractAddress: 'contract_address',
    functionName: 'deposit',
    parameters: {'amount': 100},
  );
  
  print('Call result: ${callResult.result}');
} on SmartContractException catch (e) {
  print('Contract call failed: $e');
}
```

## Advanced Usage

### Custom Server Configuration

You can configure custom server URLs for both ECDSA and contract services:

```dart
final sdk = SmartContractSDK(
  ecdsaServerUrl: 'https://your-ecdsa-server.com',
  contractServerUrl: 'https://your-contract-server.com'
);
```

### Error Handling

The package provides a custom `SmartContractException` for detailed error information:

```dart
try {
  // SDK operations
} on SmartContractException catch (e) {
  print('Operation failed: ${e.message}');
} catch (e) {
  print('Unexpected error: $e');
}
```

### Response Types

#### DeploymentResult

```dart
DeploymentResult {
  String contractAddress;    // The deployed contract's address
}
```

#### ContractCallResult

```dart
ContractCallResult {
  bool success;             // Whether the call was successful
  dynamic result;           // The function call result
}
```

## Example Project

Check out the [example](example) directory for a complete sample project demonstrating the package's features.

## Contributing

Contributions are welcome! If you find a bug or want a feature, please:

1. Check existing issues and pull requests
2. Create an issue to discuss the change
3. Submit a pull request

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and development process.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
#   s i m p l i c i t y _ s d k  
 #   s i m p l i c i t y _ s d k  
 