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
  late final String userId;
  late final String serialNumber;

  @override
  void initState() {
    super.initState();
    // Generate UUID once when screen loads
    // You can replace these with user input if needed
    userId = Uuid().v4(); //! this uer enter it
    serialNumber = Uuid().v4();
  }

  @override
  Widget build(BuildContext context) {
    final card = WalletCard(
      id: userId, // Use generated or user-entered ID
      type: WalletCardType.generic,
      platformData: {
        'issuerId': '3388000000023031029',
        'classId': '3388000000023031029.DOMAPPDEVNEW',
      },
      metadata: WalletCardMetadata(
        title: 'My Google Wallet Loyalty Card',
        description: 'Earn points with every purchase',
        organizationName: 'Your Brand',
        serialNumber: serialNumber,
      ),
      visuals: WalletCardVisuals(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        labelColor: Colors.green,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Google Wallet")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Add Loyalty Card to Google Wallet"),
          onPressed: () async {
            bool success = false;
            try {
              success = await FlutterWalletCard.addToWallet(card);
              debugPrint('Add to wallet success: $success');
            } catch (e, stack) {
              debugPrint('Error adding card to wallet: $e\n$stack');
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: $e')));
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  success ? 'Added to Google Wallet!' : 'Failed to add card.',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
