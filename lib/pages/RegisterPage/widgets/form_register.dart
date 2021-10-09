import 'dart:io';
import 'package:capyba_challenge_frontend/pages/PrivacyPolicyPage/privacy_policy_page.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/constants/validators/text_validator.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_divider.dart';
import 'package:capyba_challenge_frontend/shared/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormRegister extends StatefulWidget {
  final Function(String, String, String, String) handleSubmit;
  final bool disableForm;
  const FormRegister(
      {Key? key, required this.handleSubmit, this.disableForm = false})
      : super(key: key);

  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final AppColors _appColors = AppColors();
  final _formKey = GlobalKey<FormState>();
  final TextValidator _textValidator = TextValidator();
  final ImagePicker _imagePicker = ImagePicker();

  bool? _checkStatus = false;
  String _name = "";
  String _email = "";
  String _password = "";
  // String _confirmPassword = "";
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputText(
            title: "Nome*",
            color: Color(_appColors.get("accentPink")),
            horizontalPadding: 0,
            onSaved: _setName,
            validator: _textValidator.textIsNotEmpty,
            disableInput: widget.disableForm,
          ),
          const CustomDivider(
            height: 40,
          ),
          Text(
            "Deixe-nos ver quem é você!\nAdicione uma foto sua.*",
            style: TextStyle(color: Color(_appColors.get("accentPink"))),
          ),
          const CustomDivider(),
          SizedBox(
            width: 65,
            height: 65,
            child: _image != null
                ? Image.file(File(
                    _image!.path,
                  ))
                : InkWell(
                    onTap: widget.disableForm
                        ? () {}
                        : () async {
                            try {
                              XFile? image = await _imagePicker.pickImage(
                                  source: ImageSource.camera);
                              setState(() {
                                _image = image;
                              });
                            } catch (e) {
                              _showSnackBar(
                                  "Erro desconhecido ao iniciar a câmera!");
                            }
                          },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(_appColors.get('accentPink')))),
                      child: Text(
                        "+",
                        style: TextStyle(
                            color: Color(_appColors.get('accentPink')),
                            fontSize: 20),
                      ),
                    ),
                  ),
          ),
          const CustomDivider(),
          InputText(
            title: "E-mail*",
            color: Color(_appColors.get("accentPink")),
            horizontalPadding: 0,
            onSaved: _setEmail,
            validator: _textValidator.emailIsValid,
            disableInput: widget.disableForm,
          ),
          const CustomDivider(),
          InputText(
            title: "Senha*",
            color: Color(_appColors.get("accentPink")),
            horizontalPadding: 0,
            hiddenText: true,
            onSaved: _setPassword,
            validator: _textValidator.strongPassword,
            disableInput: widget.disableForm,
          ),
          const CustomDivider(),
          // InputText(
          //   title: "Confirmar senha*",
          //   color: Color(_appColors.get("accentPink")),
          //   horizontalPadding: 0,
          //   hiddenText: true,
          //   onSaved: _setConfirmPassword,
          //  disableInput: widget.disableForm,
          // ),
          // const CustomDivider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  value: _checkStatus,
                  fillColor: MaterialStateProperty.resolveWith(
                      (states) => Color(_appColors.get("accentPink"))),
                  onChanged: (bool? status) {
                    if (widget.disableForm) return;
                    setState(() {
                      _checkStatus = status!;
                    });
                  },
                  activeColor: Color(
                    _appColors.get("accentPink"),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: InkWell(
                  onTap: _navigateToPrivacyPolicy,
                  child: Text(
                    "Política de privacidade",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Color(_appColors.get("accentPink"))),
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
                  if (_image == null) {
                    _showSnackBar("Foto é obrigatória!");
                    return;
                  }
                  if (!_checkStatus!) {
                    _showSnackBar(
                        "É preciso aceitar os termos de privacidade!");
                    return;
                  }
                  try {
                    await widget.handleSubmit(
                        _email, _password, _image!.path, _name);
                  } catch (e) {
                    _showSnackBar("Erro!");
                  }
                }
              },
              text: "Cadastrar",
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

  // void _setConfirmPassword(text) {
  //   _confirmPassword = text;
  // }

  void _navigateToPrivacyPolicy() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()));
  }

  _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
