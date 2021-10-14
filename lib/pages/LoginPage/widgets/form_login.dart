import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/input_text.dart';
import 'package:capyba_challenge_frontend/utils/regex/regex.dart';
import 'package:capyba_challenge_frontend/utils/validators/text_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormLogin extends StatefulWidget {
  final Function(String, String) handleSubmit;
  final bool disableForm;
  const FormLogin(
      {Key? key, required this.handleSubmit, this.disableForm = false})
      : super(key: key);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  String _email = "";
  String _password = "";
  final TextValidator _textValidator = TextValidator();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InputText(
            title: Labels.get("email"),
            onSaved: _setEmail,
            validator: _textValidator.emailIsValid,
            disableInput: widget.disableForm,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp(Regex().emailRegex)),
            ],
          ),
          const Divider(
            color: Colors.transparent,
            height: 20,
          ),
          InputText(
            title: Labels.get("password"),
            hiddenText: true,
            onSaved: _setPassword,
            validator: _textValidator.textIsNotEmpty,
            disableInput: widget.disableForm,
          ),
          const Divider(
            color: Colors.transparent,
            height: 45,
          ),
          CustomButton(
            onPressed: () async {
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                widget.handleSubmit(_email, _password);
              }
            },
            text: Labels.get("toEnter"),
            loadingButton: widget.disableForm,
          )
        ],
      ),
    );
  }

  void _setEmail(text) {
    _email = text;
  }

  void _setPassword(text) {
    _password = text;
  }
}
