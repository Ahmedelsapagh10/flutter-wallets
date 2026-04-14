import 'package:flutter/material.dart';
import 'package:flutter_wallet_card/flutter_wallet_card.dart';
import 'package:flutter_wallet_card/models/wallet_card.dart';
import 'package:uuid/uuid.dart';

class GoogleWalletScreen extends StatefulWidget {
  const GoogleWalletScreen({super.key});

  @override
  State<GoogleWalletScreen> createState() => _GoogleWalletScreenState();
}

class _GoogleWalletScreenState extends State<GoogleWalletScreen> {
  static const String _issuerId = '3388000000023031029';
  static const String _classSuffix = 'NEWGOOGLEWALLET';

  late final String _memberId;
  late final String _serialNumber;
  late final Future<bool> _isWalletAvailable;

  @override
  void initState() {
    super.initState();
    _memberId = const Uuid().v4();
    _serialNumber = const Uuid().v4();
    _isWalletAvailable = FlutterWalletCard.isWalletAvailable;
  }

  String get _classId => '$_issuerId.$_classSuffix';
  bool get _isConfigured =>
      _issuerId.isNotEmpty && !_classSuffix.startsWith('REPLACE_WITH_');

  WalletCard _buildCard() {
    return WalletCard(
      id: '$_issuerId.$_memberId',
      type: WalletCardType.generic,
      platformData: {'issuerId': _issuerId, 'classId': _classId},
      metadata: WalletCardMetadata(
        title: 'DOMAPP Membership',
        description: 'Member ID: $_memberId',
        organizationName: 'DOMAPP',
        serialNumber: _serialNumber,
      ),
      visuals: const WalletCardVisuals(
        backgroundColor: Color(0xFF1A73E8),
        foregroundColor: Colors.white,
        labelColor: Color(0xFFE8F0FE),
      ),
    );
  }

  Future<void> _addGoogleCard() async {
    if (!_isConfigured) {
      _showSnack(
        'Set your real Google Wallet class suffix in google.dart',
        isError: true,
      );
      return;
    }

    try {
      final success = await FlutterWalletCard.addToWallet(_buildCard());
      _showSnack(
        success ? 'Added to Google Wallet.' : 'Card was not added.',
        isError: !success,
      );
    } catch (e) {
      _showSnack('Google Wallet error: $e', isError: true);
    }
  }

  void _showSnack(String message, {required bool isError}) {
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
      appBar: AppBar(title: const Text('Google Wallet (flutter_wallet_card)')),
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
                Text('Issuer ID: $_issuerId'),
                Text('Class ID: $_classId'),
                const SizedBox(height: 8),
                Text(
                  isAvailable
                      ? 'Wallet API is available.'
                      : 'Wallet API is not available on this device/account.',
                  style: TextStyle(
                    color: isAvailable ? Colors.green : Colors.orange,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isAvailable ? _addGoogleCard : null,
                    child: const Text('Add Generic Card to Google Wallet'),
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
