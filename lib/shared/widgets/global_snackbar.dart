import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlobalSnackbar {
  GlobalSnackbar._();
  static buildErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
