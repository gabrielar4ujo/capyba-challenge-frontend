import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String title;
  final bool hiddenText;
  const InputText({Key? key, required this.title, this.hiddenText = false }) : super(key: key);
  final Color color = const Color(0xff30475e);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        obscureText: hiddenText,  
        decoration: InputDecoration(
            labelText: title, 
            labelStyle: TextStyle(color: color),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: color)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: color))
            ),
      ),
    );
  }
}
