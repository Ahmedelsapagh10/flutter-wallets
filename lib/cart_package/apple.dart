import 'package:flutter/material.dart';
import 'package:flutter_wallet_card/flutter_wallet_card.dart';
import 'package:flutter_wallet_card/models/wallet_card.dart';

class AppleWalletScreen extends StatelessWidget {
  const AppleWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final card = WalletCard(
      id: 'user-apple-12345', //! [ 1 ] user will enter this id
      type: WalletCardType.generic,
      platformData: {
        'passTypeIdentifier':
            'pass.com.domapp.wallettest1', //! [ 2 ] get it from Certificates, Identifiers & Profiles → Identifiers. Pass Type IDs
        'teamIdentifier': 'UB7HL9MB7F', //! [ 3 ] Apple Developer Team ID
      },
      metadata: WalletCardMetadata(
        title: 'My Apple Wallet Card',
        description: 'A sample pass for Apple Wallet',
        organizationName: 'Your Company',
        serialNumber: 'USER12345', //! [ 4 ] must be unique
      ),
      visuals: WalletCardVisuals(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        labelColor: Colors.grey,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Apple Wallet")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Add Card to Apple Wallet"),
          onPressed: () async {
            bool success = false;
            try {
              success = await FlutterWalletCard.addToWallet(card);
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: $e')));
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  success ? 'Added to Apple Wallet!' : 'Failed to add card.',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
// ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:apple_passkit/apple_passkit.dart';
// import 'package:flutter/services.dart';

// class AppleScreen extends StatefulWidget {
//   const AppleScreen({super.key});

//   @override
//   State<AppleScreen> createState() => _AppleScreenState();
// }

// class _AppleScreenState extends State<AppleScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: AppleWidget());
//   }
// }

// final _applePasskitPlugin = ApplePassKit();

// class AppleWidget extends StatelessWidget {
//   const AppleWidget();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               final isAvailable = await _applePasskitPlugin
//                   .isPassLibraryAvailable();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Is library available: $isAvailable')),
//               );
//             },
//             child: const Text('Is library available?'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               final canAdd = await _applePasskitPlugin.canAddPasses();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Can add passes: $canAdd')),
//               );
//             },
//             child: const Text('Can add passes?'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await _applePasskitPlugin.addPass(await getFlightPass());
//             },
//             child: const Text('Add pass variant 1'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await _applePasskitPlugin.addPassesWithoutUI(
//                 await getMultiplePasses(),
//               );
//             },
//             child: const Text('Add multiple passes via popup'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await _applePasskitPlugin.addPasses(await getMultiplePasses());
//             },
//             child: const Text('Add multiple passes via ViewController'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               final passes = await _applePasskitPlugin.passes();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Passes: ${passes.join(', ')}')),
//               );
//             },
//             child: const Text('Passes'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Future<List<Uint8List>> getMultiplePasses() async {
//   return [await getFlightPass()];
// }

// Future<Uint8List> getFlightPass() async {
//   final pkPass = await rootBundle.load('assets/coupon.pkpass');
//   return pkPass.buffer.asUint8List(pkPass.offsetInBytes, pkPass.lengthInBytes);
// }
