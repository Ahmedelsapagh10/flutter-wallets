import 'dart:convert';

import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class GoogleWalletCard extends StatelessWidget {
  const GoogleWalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    if (!_isWalletConfigValid) {
      return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: const Text(
          'Google Wallet is not configured.\n'
          'Set valid values for issuer ID, class suffix, and service account email in google_wallet_screen.dart.',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return AddToGoogleWalletButton(
      pass: _examplePass,
      onError: (Object error) => _onError(context, error),
      onSuccess: () => _onSuccess(context),
      onCanceled: () => _onCanceled(context),
    );
  }

  void _onError(BuildContext context, Object error) {
    final String message = _extractErrorMessage(error);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red, content: Text(message)),
    );
  }

  String _extractErrorMessage(Object error) {
    if (error is Map) {
      final Object? message = error['message'];
      if (message != null) return message.toString();
    }
    return error.toString();
  }

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

final String _passId = const Uuid().v4();

// Replace with your own issuer config from Google Wallet Business Console.
const String _passClass =
    'NEWGOOGLEWALLET'; // Class suffix only, not full classId.
const String _issuerId = '3388000000023031029';
const String _issuerEmail = '177146692044@developer.gserviceaccount.com';

final bool _isWalletConfigValid =
    _issuerId.trim().isNotEmpty &&
    _passClass.trim().isNotEmpty &&
    _issuerEmail.trim().isNotEmpty &&
    (_issuerEmail.contains('.iam.gserviceaccount.com') ||
        _issuerEmail.contains('@developer.gserviceaccount.com')) &&
    !_issuerEmail.contains('REPLACE_WITH_SERVICE_ACCOUNT') &&
    !_issuerEmail.contains('PROJECT_ID');

final int _issuedAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;

final String _examplePass = jsonEncode({
  'iss': _issuerEmail,
  'aud': 'google',
  'iat': _issuedAt,
  'typ': 'savetowallet',
  'origins': <String>[],
  'payload': {
    'genericObjects': [
      {
        'id': '$_issuerId.$_passId',
        'classId': '$_issuerId.$_passClass',
        'state': 'ACTIVE',
        'cardTitle': {
          'defaultValue': {'language': 'en-US', 'value': 'DOMAPP Member'},
        },
        'header': {
          'defaultValue': {'language': 'en-US', 'value': 'DOMAPPDEVTEST'},
        },
        'barcode': {'type': 'QR_CODE', 'value': _passId},
        'textModulesData': [
          {'header': 'Member ID', 'body': _passId, 'id': 'member_info'},
        ],
      },
    ],
  },
});
