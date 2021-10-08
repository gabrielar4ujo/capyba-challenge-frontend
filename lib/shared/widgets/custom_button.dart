import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final EdgeInsets size;
  final double fontSize;
  final String backgroundColor;
  final String borderColor;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.fontSize = 18,
      this.borderColor = "mediumBlack",
      this.backgroundColor = "accentPink",
      this.size = const EdgeInsets.symmetric(horizontal: 25, vertical: 15)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppColors _appColors = AppColors();
    return ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
            primary: Color(_appColors.get(backgroundColor)),
            padding: size,
            side: BorderSide(color: Color(_appColors.get(borderColor))),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)))),
        child: Text(
          text.toString(),
          style: TextStyle(
              color: Color(_appColors.get(borderColor)), fontSize: fontSize),
        ));
  }
}
