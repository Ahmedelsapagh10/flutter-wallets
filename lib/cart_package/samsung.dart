// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:samsung_wallet/samsung_wallet.dart';

// class SamsungScreen extends StatefulWidget {
//   const SamsungScreen({super.key});

//   @override
//   State<SamsungScreen> createState() => _SamsungScreenState();
// }

// class _SamsungScreenState extends State<SamsungScreen> {
//   static const String impressionUrl = "[ Impression Url ]";

//   /// optional
//   ///
//   /// Country code
//   static const String countryCode = "[ CountryCode ]";

//   /// mandatory
//   ///
//   /// Partner code obtained from Partners Portal
//   /// Value granted from the Partners portal.
//   ///
//   /// Check your Wallet Cards in Samsung Wallet Partners
//   static const String partnerCode = "[ Partner Code ]";

//   /// mandatory
//   ///
//   /// Wallet card identifier obtained from Partners Portal
//   /// Value granted from the Partners Portal.
//   ///
//   /// Check your Wallet Cards in Manage Wallet Cards which you want add Wallet Card App Integration
//   static const String cardId = "[ Card Id ]";

//   /// mandatory
//   /// You can get cdata to JWT Generator
//   static const String cdata = "[ CData ]";

//   /// mandatory
//   ///
//   /// Encrypted card object (JSON).
//   /// This field needs to be encrypted.
//   ///
//   /// Refer to [Security](https://developer.samsung.com/wallet/api/security.html)
//   /// for more details.
//   ///
//   /// Check your Wallet Cards in Manage Wallet Cards which you want add Wallet Card App Integration
//   static const String clickUrl = "[ Click Url ]";

//   final _samsungWalletPlugin = SamsungWallet(
//     countryCode: countryCode,
//     partnerCode: partnerCode,
//     impressionURL: impressionUrl,
//   );

//   Future<void> checkSamsungWalletSupported() async {
//     try {
//       await _samsungWalletPlugin.checkSamsungWalletSupported(
//             partnerCode: partnerCode,
//             countryCode: 'KR',
//           ) ??
//           false;
//     } catch (e) {
//       log("ERROR : $e");
//     }
//   }

//   addCard() async {
//     await _samsungWalletPlugin.addCardToSamsungWallet(
//       cardID: cardId,
//       cData: cdata,
//       clickURL: clickUrl,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Samsung Wallet Demo')),
//       body: Center(
//         child: Column(
//           children: [
//             const Text('Hello Samsung Wallet!'),
//             const SizedBox(height: 50),
//             AddToSamsungWalletButton(
//               onTapAddCard: addCard,
//               buttonDesignType: ButtonDesignType.iconBasic,
//               buttonTextPositionType: ButtonTextPositionType.hor,
//               buttonThemeType: ButtonThemeType.pos,
//             ),
//             const SizedBox(height: 50),
//             AddToSamsungWalletButton.testTool(),
//           ],
//         ),
//       ),
//     );
//   }
// }
