import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final Function(String)? validator;
  final String title;
  final bool hiddenText;
  final bool? disableInput;
  final Color color;
  final double horizontalPadding;
  final Function? onSaved;
  const InputText(
      {Key? key,
      required this.title,
      required this.onSaved,
      this.hiddenText = false,
      this.validator,
      this.disableInput = false,
      this.color = const Color(0xff30475e),
      this.horizontalPadding = 40})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: TextFormField(
        cursorColor: Colors.white,
        enabled: !disableInput!,
        validator: (text) {
          if (validator == null) return null;
          return validator!(text.toString());
        },
        onSaved: (text) => onSaved!(text),
        style: const TextStyle(color: Colors.white),
        obscureText: hiddenText,
        decoration: InputDecoration(
            errorStyle: const TextStyle(height: 1, color: Colors.white70),
            labelText: title,
            labelStyle: TextStyle(color: color),
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color))),
      ),
    );
  }
}
