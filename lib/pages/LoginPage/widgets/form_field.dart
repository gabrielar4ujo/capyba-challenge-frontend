import 'package:capyba_challenge_frontend/locales/pt_br/labels.dart';
import 'package:capyba_challenge_frontend/shared/widgets/input_text.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const CustomFormField({Key? key, required this.formKey}) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InputText(
            title: Labels().get("email"),
          ),
          const Divider(
            color: Colors.transparent,
            height: 45,
          ),
          InputText(
            title: Labels().get("password"),
            hiddenText: true,
          ),
          const Divider(
            color: Colors.transparent,
            height: 45,
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xfff05454),
                  onSurface: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  side: const BorderSide(color: Color(0xff222831)),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)))),
              child: const Text(
                "Entrar",
                style: TextStyle(color: Color(0xff222831), fontSize: 18),
              )),
        ],
      ),
    );
  }
}
