import 'package:flutter/material.dart';
import 'package:wallet_app/cart_package/apple.dart';
import 'package:wallet_app/cart_package/google.dart';
import 'package:wallet_app/cart_package/samsung.dart';
import 'package:wallet_app/google_wallet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Wallets')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GoogleWalletCard(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AppleWalletScreen()),
              );
            },
            style: ButtonStyle(),
            child: const Text('Apple Wallet (flutter_wallet_card)'),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GoogleWalletScreen()),
              );
            },
            child: const Text('Google Wallet (flutter_wallet_card)'),
          ),
          ElevatedButton(
            style: ButtonStyle(),
            child: const Text('Add to Samsung Wallet'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SamsungScreen()),
              );
            },
          ),
          // const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
