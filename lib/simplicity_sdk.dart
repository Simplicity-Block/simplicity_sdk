// lib/simplicity_sdk.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class SmartContractSDK {
  final String _ecdsaServerUrl;
  final String _contractServerUrl;
  String? _publicKey;

  SmartContractSDK({
    String? ecdsaServerUrl,
    String? contractServerUrl,
  })  : _ecdsaServerUrl = ecdsaServerUrl ?? 'https://ecdsa-server.onrender.com',
        _contractServerUrl =
            contractServerUrl ?? 'https://simplicity-server.onrender.com';

  Future<String> getPublicKey(String privateKey) async {
    try {
      final response = await http.post(
        Uri.parse('$_ecdsaServerUrl/private_to_public'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'private_key': privateKey,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _publicKey = data['public_key'];
        return _publicKey!;
      } else {
        throw SmartContractException(
            'Failed to get public key: ${response.body}');
      }
    } catch (e) {
      throw SmartContractException('Error getting public key: $e');
    }
  }

  Future<String?> _signPayload(
      String privateKey, Map<String, dynamic> payload) async {
    try {
      final serializablePayload = Map<String, dynamic>.from(payload);

      final response = await http.post(
        Uri.parse('$_ecdsaServerUrl/sign_payload'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'private_key': privateKey,
          'payload': serializablePayload,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['signed_payload'];
      } else {
        throw SmartContractException(
            'Failed to sign payload: ${response.body}');
      }
    } catch (e) {
      throw SmartContractException('Error signing payload: $e');
    }
  }

  Future<DeploymentResult> deployContract({
    required String privateKey,
    required String contractName,
    required String contractCode,
  }) async {
    try {
      final publicKey = await getPublicKey(privateKey);

      final deploymentPayload = {
        'sender': publicKey,
        'contract_name': contractName,
        'code': contractCode,
        'timestamp': DateTime.now().millisecondsSinceEpoch / 1000,
        'public_key': publicKey,
      };

      final signature = await _signPayload(privateKey, deploymentPayload);
      if (signature == null) {
        throw SmartContractException('Failed to sign deployment payload');
      }

      final deploymentData = {
        ...deploymentPayload,
        'digital_signature': signature,
      };

      final response = await http.post(
        Uri.parse('$_contractServerUrl/contracts/new'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(deploymentData),
      );
      // Regular Expression to extract only the contract address

      if (response.statusCode == 201) {
        final data = response.body;
        RegExp regex = RegExp(r'(?<=Contract address is\s)[a-f0-9]+');

        // Search for the contract address in the message
        Match? match = regex.firstMatch(data);

        if (match != null) {
          String _contractAddress = match.group(0)!;
          return DeploymentResult(
              contractAddress: _contractAddress,
              transactionHash: _contractAddress);
        } else {
          throw SmartContractException('No contract address found.');
        }
      } else {
        throw SmartContractException(
            'Failed to deploy contract: ${response.body}');
      }
    } catch (e) {
      throw SmartContractException('Error deploying contract: $e');
    }
  }

  Future<ContractCallResult> callContract({
    required String privateKey,
    required String contractAddress,
    required String functionName,
    Map<String, dynamic> parameters = const {},
  }) async {
    try {
      final publicKey = await getPublicKey(privateKey);

      final callPayload = {
        'sender': publicKey,
        'contract_address': contractAddress,
        'function': functionName,
        'parameters': parameters,
        'timestamp': DateTime.now().millisecondsSinceEpoch / 1000,
        'public_key': publicKey,
      };

      final signature = await _signPayload(privateKey, callPayload);
      if (signature == null) {
        throw SmartContractException('Failed to sign contract call payload');
      }

      final callData = {
        ...callPayload,
        'digital_signature': signature,
      };

      final response = await http.post(
        Uri.parse('$_contractServerUrl/contracts/call'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(callData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ContractCallResult(
          success: true,
          result: data,
        );
      } else {
        throw SmartContractException('Contract call failed: ${response.body}');
      }
    } catch (e) {
      throw SmartContractException('Error calling contract: $e');
    }
  }
}

class SmartContractException implements Exception {
  final String message;
  SmartContractException(this.message);

  @override
  String toString() => 'SmartContractException: $message';
}

class DeploymentResult {
  final String contractAddress;
  final String? transactionHash;

  DeploymentResult({
    required this.contractAddress,
    this.transactionHash,
  });
}

class ContractCallResult {
  final bool success;
  final dynamic result;

  ContractCallResult({
    required this.success,
    required this.result,
  });
}
