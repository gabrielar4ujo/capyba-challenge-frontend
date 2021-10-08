import 'package:capyba_challenge_frontend/pages/LoginPage/widgets/form_field.dart';
import 'package:capyba_challenge_frontend/pages/RegisterPage/register_page.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    final AppColors _appColors = AppColors();
    void _navigateToRegister() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RegisterPage()));
    }

    return Scaffold(
      backgroundColor: Color(_appColors.get("accentPink")),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(_appColors.get("accentPink")),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(title: "Login"),
            ConstrainedBox(
                constraints: BoxConstraints(minHeight: _height * 0.55),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: CustomFormField(
                    formKey: _formKey,
                  ),
                )),
            Container(
              width: _width,
              height: 30,
              color: Color(_appColors.get("white92")),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 150,
              ),
              child: Container(
                width: _width,
                height: (_height * 0.45) - 150,
                color: Color(_appColors.get("darkBlue")),
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Ainda não é cadastrado?",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(_appColors.get("white92"))),
                    ),
                    const Divider(
                      color: Colors.transparent,
                      height: 15,
                    ),
                    CustomButton(
                      onPressed: _navigateToRegister,
                      text: "Cadastre-se",
                      fontSize: 14,
                      size: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
