import 'package:capyba_challenge_frontend/config/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final EdgeInsets size;
  final double fontSize;
  final String backgroundColor;
  final String borderColor;
  final bool disableButton;
  final bool loadingButton;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.fontSize = 18,
      this.borderColor = "darkBlue",
      this.backgroundColor = "accentPink",
      this.disableButton = false,
      this.loadingButton = false,
      this.size = const EdgeInsets.symmetric(horizontal: 25, vertical: 15)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:
            (!disableButton && !loadingButton) ? () => onPressed() : () {},
        style: ElevatedButton.styleFrom(
            primary: Color(AppColors.get(backgroundColor)),
            padding: size,
            side: BorderSide(color: Color(AppColors.get(borderColor))),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)))),
        child: loadingButton
            ? SizedBox(
                child: CircularProgressIndicator(
                  color: Color(AppColors.get("lightGray")),
                ),
                height: 21,
                width: 21,
              )
            : Text(
                text.toString(),
                style: TextStyle(
                    color: Color(AppColors.get(borderColor)),
                    fontSize: fontSize),
              ));
  }
}
