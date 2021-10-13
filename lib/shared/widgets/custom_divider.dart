import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  const CustomDivider({Key? key, this.height = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.transparent,
      height: height,
    );
  }
}
