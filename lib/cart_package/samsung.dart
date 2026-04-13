import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:samsung_wallet/samsung_wallet.dart';

class SamsungScreen extends StatefulWidget {
  const SamsungScreen({super.key});

  @override
  State<SamsungScreen> createState() => _SamsungScreenState();
}

class _SamsungScreenState extends State<SamsungScreen> {
  static const String impressionUrl =
      "https://us-rd.mcsvc.samsung.com/statistics/impression/addtowlt?ep=C50C3754FEB24833B30C10B275BB6AB8;cc=GC;ii=4063269063441135936;co=4130875726818138240;cp=1288017491089625089;si=24;pg=4058691328745130560;pi=Aqz68EBXSx6Mv9jsaZxzaA;tp=4130878662665138496;li=0";

  /// optional
  ///
  /// Country code
  static const String countryCode = "EG";

  /// mandatory
  ///
  /// Partner code obtained from Partners Portal
  /// Value granted from the Partners portal.
  ///
  /// Check your Wallet Cards in Samsung Wallet Partners
  static const String partnerCode = "4130875726818138240";

  /// mandatory
  ///
  /// Wallet card identifier obtained from Partners Portal
  /// Value granted from the Partners Portal.
  ///
  /// Check your Wallet Cards in Manage Wallet Cards which you want add Wallet Card App Integration
  static const String cardId = "3ikujsj7psig0";

  /// mandatory
  /// You can get cdata to JWT Generator
  static const String cdata =
      "<a href=\"https://a.swallet.link/atw/v1/3ikujsj7psig0#Clip?pdata=ref-20230304-0003\"><img src=\"https://us-cdn-gpp.mcsvc.samsung.com/lib/wallet-card.png\" alt=\"\"/><img src=\"https://us-rd.mcsvc.samsung.com/statistics/impression/addtowlt?ep=C50C3754FEB24833B30C10B275BB6AB8;cc=GC;ii=4063269063441135936;co=4130875726818138240;cp=1288017491089625089;si=24;pg=4058691328745130560;pi=Aqz68EBXSx6Mv9jsaZxzaA;tp=4130878662665138496;li=0\" style=\"width:1px; height:1px;\" alt=\"\"/></a>";
  // "<a href=\"https://a.swallet.link/atw/v1/3ikujsj7psig0#Clip?pdata=${refId}\"><img src=\"https://us-cdn-gpp.mcsvc.samsung.com/lib/wallet-card.png\" alt=\"\"/><img src=\"https://us-rd.mcsvc.samsung.com/statistics/impression/addtowlt?ep=C50C3754FEB24833B30C10B275BB6AB8;cc=GC;ii=4063269063441135936;co=4130875726818138240;cp=1288017491089625089;si=24;pg=4058691328745130560;pi=Aqz68EBXSx6Mv9jsaZxzaA;tp=4130878662665138496;li=0\" style=\"width:1px; height:1px;\" alt=\"\"/></a>";

  /// mandatory
  ///
  /// Encrypted card object (JSON).
  /// This field needs to be encrypted.
  ///
  /// Refer to [Security](https://developer.samsung.com/wallet/api/security.html)
  /// for more details.
  ///
  /// Check your Wallet Cards in Manage Wallet Cards which you want add Wallet Card App Integration
  static const String clickUrl =
      "https://us-rd.mcsvc.samsung.com/statistics/click/addtowlt?ep=C50C3754FEB24833B30C10B275BB6AB8;cc=GC;ii=4063269063441135936;co=4130875726818138240;cp=1288017491089625089;si=24;pg=4058691328745130560;pi=Aqz68EBXSx6Mv9jsaZxzaA;tp=4130878662665138496;li=0";

  final _samsungWalletPlugin = SamsungWallet(
    countryCode: countryCode,
    partnerCode: partnerCode,
    impressionURL: impressionUrl,
  );

  Future<void> checkSamsungWalletSupported() async {
    try {
      await _samsungWalletPlugin.checkSamsungWalletSupported(
            partnerCode: partnerCode,
            countryCode: 'EG',
          ) ??
          false;
    } catch (e) {
      log("ERROR : $e");
    }
  }

  addCard() async {
    await _samsungWalletPlugin.addCardToSamsungWallet(
      cardID: cardId,
      cData: cdata,
      clickURL: clickUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Samsung Wallet Demo')),
      body: Center(
        child: Column(
          children: [
            const Text('Hello Samsung Wallet!'),
            const SizedBox(height: 50),
            AddToSamsungWalletButton(
              onTapAddCard: addCard,
              buttonDesignType: ButtonDesignType.iconBasic,
              buttonTextPositionType: ButtonTextPositionType.hor,
              buttonThemeType: ButtonThemeType.pos,
            ),
            const SizedBox(height: 50),
            AddToSamsungWalletButton.testTool(),
          ],
        ),
      ),
    );
  }
}
