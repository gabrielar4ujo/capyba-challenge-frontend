import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/input_text.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AppColors _appColors = AppColors();
  final _formKey = GlobalKey<FormState>();
  bool? _checkStatus = false;
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _statusBarHeight = MediaQuery.of(context).padding.top;
    final _appBarHeight = AppBar().preferredSize.height;
    Widget _space({double height = 20}) {
      return Divider(
        color: Colors.transparent,
        height: height,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastre-se"),
        backgroundColor: Color(_appColors.get("darkBlue")),
      ),
      backgroundColor: Color(_appColors.get("accentPink")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.bottomCenter,
          height: _height - _statusBarHeight - _appBarHeight,
          constraints: const BoxConstraints(
            minHeight: 650,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Color(_appColors.get("darkBlue"))),
            height: _height * 0.85,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputText(
                    title: "Nome*",
                    color: Color(AppColors().get("accentPink")),
                    horizontalPadding: 0,
                  ),
                  _space(height: 40),
                  Text(
                    "Deixe-nos ver quem é você!\nAdicione uma foto sua.*",
                    style: TextStyle(color: Color(AppColors().get("accentPink"))),
                  ),
                  _space(),
                  Container(
                    width: 65,
                    height: 65,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(AppColors().get('accentPink')))),
                    child: Text(
                      "+",
                      style: TextStyle(
                          color: Color(AppColors().get('accentPink')),
                          fontSize: 20),
                    ),
                  ),
                  _space(),
                  InputText(
                    title: "E-mail*",
                    color: Color(AppColors().get("accentPink")),
                    horizontalPadding: 0,
                  ),
                  _space(),
                  InputText(
                    title: "Senha*",
                    color: Color(AppColors().get("accentPink")),
                    horizontalPadding: 0,
                    hiddenText: true,
                  ),
                  _space(),
                  InputText(
                    title: "Confirmar senha*",
                    color: Color(AppColors().get("accentPink")),
                    horizontalPadding: 0,
                    hiddenText: true,
                  ),
                  _space(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                         visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          value: _checkStatus,
                          fillColor: MaterialStateProperty.resolveWith(
                              (states) => Color(AppColors().get("accentPink"))),
                          onChanged: (bool? status) {
                            setState(() {
                              _checkStatus = status!;
                            });
                          },
                          activeColor: Color(
                            AppColors().get("accentPink"),
                          )),
                      Text(
                        "Política de privacidade",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                            color: Color(AppColors().get("accentPink"))),
                            
                      )
                    ],
                  ),
                  _space(height: 25),
                  Center(
                    child: CustomButton(
                      onPressed: () {},
                      text: "Cadastrar",
                      backgroundColor: "darkBlue",
                      borderColor: "accentPink",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
