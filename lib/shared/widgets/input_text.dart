import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatelessWidget {
  final Function(String)? validator;
  final String title;
  final bool hiddenText;
  final bool? disableInput;
  final Color color;
  final double horizontalPadding;
  final Function? onSaved;
  final List<TextInputFormatter>? formatter;
  final TextCapitalization? capitalization;
  final int? maxLines;
  const InputText(
      {Key? key,
      required this.title,
      required this.onSaved,
      this.hiddenText = false,
      this.validator,
      this.disableInput = false,
      this.color = const Color(0xff30475e),
      this.horizontalPadding = 40,
      this.capitalization = TextCapitalization.none,
      this.maxLines = 1,
      this.formatter})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var border = maxLines! == 1
        ? UnderlineInputBorder(borderSide: BorderSide(color: color))
        : OutlineInputBorder(borderSide: BorderSide(color: color));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: TextFormField(
        textCapitalization: capitalization!,
        inputFormatters: formatter,
        cursorColor: Color(AppColors.get("lightGray")),
        enabled: !disableInput!,
        validator: (text) {
          if (validator == null) return null;
          return validator!(text.toString());
        },
        onSaved: (text) => onSaved!(text),
        style: TextStyle(color: Color(AppColors.get("lightGray"))),
        obscureText: hiddenText,
        minLines: maxLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          errorStyle: const TextStyle(height: 1, color: Colors.white70),
          labelText: title,
          labelStyle: TextStyle(color: color),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border,
          border: border,
        ),
      ),
    );
  }
}
