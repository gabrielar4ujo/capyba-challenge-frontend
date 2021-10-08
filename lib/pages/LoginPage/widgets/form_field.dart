import 'package:capyba_challenge_frontend/locales/pt_br/labels.dart';
import 'package:capyba_challenge_frontend/shared/constants/validators/text_validator.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/input_text.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const CustomFormField({Key? key, required this.formKey}) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  String _email = "";
  String _password = "";
  final TextValidator _textValidator = TextValidator();

  void _setEmail(text) {
    setState(() {
      _email = text;
    });
  }

  void _setPassword(text) {
    setState(() {
      _password = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InputText(
            title: Labels().get("email"),
            onSaved: _setEmail,
            validator: _textValidator.emailIsValid,
            errorMessage: "Email inválido!"
          ),
          const Divider(
            color: Colors.transparent,
            height: 45,
          ),
          InputText(
            title: Labels().get("password"),
            hiddenText: true,
            onSaved: _setPassword,
            validator: _textValidator.textIsNotEmpty,
             errorMessage: "Campo de senha não pode ser vazio!"
          ),
          const Divider(
            color: Colors.transparent,
            height: 45,
          ),
          CustomButton(
              onPressed: () {
                widget.formKey.currentState!.save();
                if (widget.formKey.currentState!.validate())
                  print("chamar login");
                else
                  print("Error, não chamar login");
                print("Email: $_email\nPassword: $_password");
              },
              text: "Entrar")
        ],
      ),
    );
  }
}
