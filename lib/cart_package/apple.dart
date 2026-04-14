import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallet_card/flutter_wallet_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AppleWalletScreen extends StatefulWidget {
  const AppleWalletScreen({super.key});

  @override
  State<AppleWalletScreen> createState() => _AppleWalletScreenState();
}

class _AppleWalletScreenState extends State<AppleWalletScreen> {
  static const bool _useLocalAsset = true;
  static const String _localPassAsset = 'assets/passes/domapp.pkpass';
  static const String _signedPassUrl = 'https://walletpasses.io/sample.pkpass';

  late final String _requestId;
  late final Future<bool> _isWalletAvailable;

  bool get _isConfigured => _useLocalAsset
      ? _localPassAsset.endsWith('.pkpass')
      : !_signedPassUrl.contains('example.com');

  @override
  void initState() {
    super.initState();
    _requestId = const Uuid().v4();
    _isWalletAvailable = FlutterWalletCard.isWalletAvailable;
  }

  Future<void> _addApplePass() async {
    if (!_isConfigured) {
      _showMessage(
        _useLocalAsset
            ? 'Put signed pass file at assets/passes/domapp.pkpass'
            : 'Set your real signed .pkpass URL in apple.dart',
        isError: true,
      );
      return;
    }

    try {
      final success = _useLocalAsset
          ? await _addApplePassFromAsset()
          : await _addApplePassFromUrl();
      _showMessage(
        success ? 'Added to Apple Wallet.' : 'Card was not added.',
        isError: !success,
      );
    } catch (e) {
      _showMessage('Apple Wallet error: $e', isError: true);
    }
  }

  Future<bool> _addApplePassFromAsset() async {
    final byteData = await rootBundle.load(_localPassAsset);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/domapp_$_requestId.pkpass');
    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
      flush: true,
    );
    return FlutterWalletCard.addFromFile(file);
  }

  Future<bool> _addApplePassFromUrl() async {
    final url = '$_signedPassUrl?requestId=$_requestId';
    return FlutterWalletCard.addFromUrl(url);
  }

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apple Wallet (flutter_wallet_card)')),
      body: FutureBuilder<bool>(
        future: _isWalletAvailable,
        builder: (context, snapshot) {
          final isAvailable = snapshot.data == true;
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _useLocalAsset
                      ? 'Signed pass asset: $_localPassAsset'
                      : 'Signed pass URL: $_signedPassUrl',
                ),
                const SizedBox(height: 8),
                Text(
                  isAvailable
                      ? 'Wallet API is available.'
                      : 'Wallet API is not available on this device.',
                  style: TextStyle(
                    color: isAvailable ? Colors.green : Colors.orange,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAvailable ? _addApplePass : null,
                    child: Text(
                      _useLocalAsset
                          ? 'Add Signed .pkpass from App Asset'
                          : 'Add Signed .pkpass to Apple Wallet',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
