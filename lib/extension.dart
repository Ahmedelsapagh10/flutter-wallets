import 'package:flutter/material.dart';

extension NavigationClass on BuildContext {
  void to(Widget child) {
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => child));
  }
}
