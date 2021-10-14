import 'dart:io';
import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/pages/PrivacyPolicyPage/privacy_policy_page.dart';
import 'package:capyba_challenge_frontend/shared/camera/camera.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/constants/regex/regex.dart';
import 'package:capyba_challenge_frontend/shared/constants/validators/text_validator.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_divider.dart';
import 'package:capyba_challenge_frontend/shared/widgets/global_snackbar.dart';
import 'package:capyba_challenge_frontend/shared/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormRegister extends StatefulWidget {
  final Function(String, String, File, String) handleSubmit;
  final bool disableForm;
  const FormRegister(
      {Key? key, required this.handleSubmit, this.disableForm = false})
      : super(key: key);

  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextValidator _textValidator = TextValidator();
  final Camera _imagePicker = Camera();

  bool? _checkStatus = false;
  String _name = "";
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputText(
            capitalization: TextCapitalization.words,
            title: Labels.get("mandatoryName"),
            color: Color(AppColors.get("accentPink")),
            horizontalPadding: 0,
            onSaved: _setName,
            validator: _textValidator.textIsNotEmpty,
            disableInput: widget.disableForm,
          ),
          const CustomDivider(
            height: 40,
          ),
          Text(
            Labels.get("takeYourPicture"),
            style: TextStyle(color: Color(AppColors.get("accentPink"))),
          ),
          const CustomDivider(),
          SizedBox(
            width: 65,
            height: 65,
            child: _imagePicker.image != null
                ? Image.file(File(
                    _imagePicker.image!.path,
                  ))
                : InkWell(
                    onTap: widget.disableForm
                        ? () {}
                        : () async {
                            try {
                              await _imagePicker.takePicture();
                              setState(() {});
                            } catch (e) {
                              GlobalSnackbar.buildErrorSnackbar(
                                  context, Labels.get("errorCamera"));
                            }
                          },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(AppColors.get('accentPink')))),
                      child: Text(
                        "+",
                        style: TextStyle(
                            color: Color(AppColors.get('accentPink')),
                            fontSize: 20),
                      ),
                    ),
                  ),
          ),
          const CustomDivider(),
          InputText(
            title: Labels.get("mandatoryEmail"),
            formatter: [
              FilteringTextInputFormatter.allow(RegExp(Regex().emailRegex)),
            ],
            color: Color(AppColors.get("accentPink")),
            horizontalPadding: 0,
            onSaved: _setEmail,
            validator: _textValidator.emailIsValid,
            disableInput: widget.disableForm,
          ),
          const CustomDivider(),
          InputText(
            title: Labels.get("mandatoryPassword"),
            color: Color(AppColors.get("accentPink")),
            horizontalPadding: 0,
            hiddenText: true,
            onSaved: _setPassword,
            validator: _textValidator.strongPassword,
            disableInput: widget.disableForm,
          ),
          const CustomDivider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  value: _checkStatus,
                  fillColor: MaterialStateProperty.resolveWith(
                      (states) => Color(AppColors.get("accentPink"))),
                  onChanged: (bool? status) {
                    if (widget.disableForm) return;
                    setState(() {
                      _checkStatus = status!;
                    });
                  },
                  activeColor: Color(
                    AppColors.get("accentPink"),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: InkWell(
                  onTap: widget.disableForm ? () {} : _navigateToPrivacyPolicy,
                  child: Text(
                    Labels.get("privacyPolicy"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Color(AppColors.get("accentPink"))),
                  ),
                ),
              )
            ],
          ),
          const CustomDivider(height: 25),
          Center(
            child: CustomButton(
              loadingButton: widget.disableForm,
              onPressed: () async {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  if (_imagePicker.image == null) {
                    GlobalSnackbar.buildErrorSnackbar(
                        context, Labels.get("mandatoryPicture"));
                    return;
                  }
                  if (!_checkStatus!) {
                    GlobalSnackbar.buildErrorSnackbar(
                        context, Labels.get("mandatoryPrivacyPolicy"));
                    return;
                  }

                  await widget.handleSubmit(
                      _email, _password, File(_imagePicker.image!.path), _name);
                }
              },
              text: Labels.get("pressRegister"),
              backgroundColor: "darkBlue",
              borderColor: "accentPink",
            ),
          ),
        ],
      ),
    );
  }

  void _setName(text) {
    _name = text;
  }

  void _setEmail(text) {
    _email = text;
  }

  void _setPassword(text) {
    _password = text;
  }

  void _navigateToPrivacyPolicy() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()));
  }
}
