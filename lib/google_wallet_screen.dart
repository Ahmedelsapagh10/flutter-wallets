import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class GoogleWalletCard extends StatelessWidget {
  const GoogleWalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AddToGoogleWalletButton(
      pass: _examplePass,
      onError: (Object error) => _onError(context, error),
      onSuccess: () => _onSuccess(context),
      onCanceled: () => _onCanceled(context),
    );
  }

  void _onError(BuildContext context, Object error) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(error.toString())),
      );

  void _onSuccess(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Pass has been successfully added to the Google Wallet.',
          ),
        ),
      );

  void _onCanceled(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.yellow,
          content: Text('Adding a pass has been canceled.'),
        ),
      );
}

final String _passId = const Uuid()
    .v4(); //! it's value of qr code and we will change it later and user enter his member id
const String _passClass = 'DOMAPPDEVNEW';
const String _issuerId = '3388000000023031029';
const String _issuerEmail = 'ahmedelsapagh179@gmail.com';

final String _examplePass =
    """
    {
      "iss": "$_issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$_issuerId.$_passId",
            "classId": "$_issuerId.$_passClass",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#4285f4",
            "logo": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Google I/O '22 [DEMO ONLY]"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Attendee"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "DOMAPPDEVTEST"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$_passId"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://www.domapphub.com/_next/static/media/logo.0dc29054.webp"
                // "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.jpg"
              }
            },
            "textModulesData": [
              {
                "header": "POINTS",
                "body": "1234",
                "id": "points"
              }
            ]
          }
        ]
      }
    }
""";
