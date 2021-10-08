import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final Function(String)? validator;
  final String title;
  final bool hiddenText;
  final Color color;
  final double horizontalPadding;
  final Function? onSaved;
  final String errorMessage;
  const InputText(
      {Key? key,
      required this.title,
      // required this.onSaved,
      this.onSaved,
      this.hiddenText = false,
      this.errorMessage = "",
      this.validator,
      this.color = const Color(0xff30475e),
      this.horizontalPadding = 40})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: TextFormField(
        cursorColor: Colors.white,
        validator: (text) {
          if (!validator!(text.toString())) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(errorMessage),
            ));
            return "";
          }
        },
        onSaved: (text) => onSaved!(text),
        style: const TextStyle(color: Colors.white),
        obscureText: hiddenText,
        decoration: InputDecoration(
            errorStyle: const TextStyle(height: 0),
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
