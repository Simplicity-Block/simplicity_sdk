// example/lib/main.dart
import 'package:flutter/material.dart';
import 'package:simplicity_sdk/simplicity_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Contract SDK Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExamplesScreen(),
    );
  }
}

class ExamplesScreen extends StatefulWidget {
  const ExamplesScreen({Key? key}) : super(key: key);

  @override
  State<ExamplesScreen> createState() => _ExamplesScreenState();
}

class _ExamplesScreenState extends State<ExamplesScreen> {
  final sdk = SmartContractSDK();
  final privateKeyController = TextEditingController();
  String outputText = '';
  String? deployedContractAddress;

  // Sample contract code templates
  static const walletContract = '''
contract wallet with amount, address does
    deposit takes amount does
        save balance is balance + amount
        return balance
    .
    
    withdraw takes amount does
        if balance > amount then
            balance is balance - amount
            return balance
        otherwise             
            return "Insufficient balance"
        .
    .
    
    transfer_to takes amount, address does
        transfer amount to address
        return "Success"
    .
.''';

  static const tokenContract = '''
contract token with name, symbol, total_supply does
    mint takes amount does
        save total_supply is total_supply + amount
        return total_supply
    .
    
    burn takes amount does
        if total_supply >= amount then
            total_supply is total_supply - amount
            return total_supply
        otherwise
            return "Insufficient supply"
        .
    .
.''';

  // Example 1: Deploy a Wallet Contract
  Future<void> deployWalletContract() async {
    try {
      setState(() => outputText = 'Deploying wallet contract...');

      final result = await sdk.deployContract(
        privateKey: privateKeyController.text,
        contractName: 'MyWallet',
        contractCode: walletContract,
      );

      setState(() {
        deployedContractAddress = result.contractAddress;
        outputText = '''
Wallet contract deployed successfully!
Address: ${result.contractAddress}
Transaction: ${result.transactionHash}''';
      });
    } on SmartContractException catch (e) {
      setState(() => outputText = 'Deployment failed: ${e.message}');
    }
  }

  // Example 2: Deposit to Wallet
  Future<void> depositToWallet() async {
    if (deployedContractAddress == null) {
      setState(() => outputText = 'Please deploy a wallet contract first');
      return;
    }

    try {
      setState(() => outputText = 'Making deposit...');

      final result = await sdk.callContract(
        privateKey: privateKeyController.text,
        contractAddress: deployedContractAddress!,
        functionName: 'deposit',
        parameters: {'amount': 100},
      );

      setState(() => outputText = '''
Deposit successful!
New balance: ${result.result}
''');
    } on SmartContractException catch (e) {
      setState(() => outputText = 'Deposit failed: ${e.message}');
    }
  }

  // Example 3: Deploy a Token Contract
  Future<void> deployTokenContract() async {
    try {
      setState(() => outputText = 'Deploying token contract...');

      final result = await sdk.deployContract(
        privateKey: privateKeyController.text,
        contractName: 'MyToken',
        contractCode: tokenContract,
      );

      setState(() {
        deployedContractAddress = result.contractAddress;
        outputText = '''
Token contract deployed successfully!
Address: ${result.contractAddress}
Transaction: ${result.transactionHash}''';
      });
    } on SmartContractException catch (e) {
      setState(() => outputText = 'Deployment failed: ${e.message}');
    }
  }

  // Example 4: Mint Tokens
  Future<void> mintTokens() async {
    if (deployedContractAddress == null) {
      setState(() => outputText = 'Please deploy a token contract first');
      return;
    }

    try {
      setState(() => outputText = 'Minting tokens...');

      final result = await sdk.callContract(
        privateKey: privateKeyController.text,
        contractAddress: deployedContractAddress!,
        functionName: 'mint',
        parameters: {'amount': 1000},
      );

      setState(() => outputText = '''
Tokens minted successfully!
New supply: ${result.result}
''');
    } on SmartContractException catch (e) {
      setState(() => outputText = 'Minting failed: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Contract SDK Examples'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: privateKeyController,
              decoration: const InputDecoration(
                labelText: 'Private Key',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Wallet Contract Examples:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: deployWalletContract,
                    child: const Text('Deploy Wallet'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: depositToWallet,
                    child: const Text('Deposit 100'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Token Contract Examples:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: deployTokenContract,
                    child: const Text('Deploy Token'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: mintTokens,
                    child: const Text('Mint 1000'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Output:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SingleChildScrollView(
                  child: Text(outputText),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    privateKeyController.dispose();
    super.dispose();
  }
}
