import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlobalSnackbar {
  GlobalSnackbar._();
  static showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
