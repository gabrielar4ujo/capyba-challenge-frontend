import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/pages/HomePage/home_page.dart';
import 'package:capyba_challenge_frontend/pages/LoginPage/widgets/form_login.dart';
import 'package:capyba_challenge_frontend/pages/RegisterPage/register_page.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_divider.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    AuthService _authService = Provider.of<AuthService>(context);

    void _handleSubmit(String email, String password) async {
      try {
        await _authService.login(email, password);
        _navigateToHome();
      } catch (e) {
        _showSnackBar(Labels.get("errorLogin"));
      }
    }

    void _navigateToRegister() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RegisterPage()));
    }

    return Scaffold(
      backgroundColor: Color(AppColors.get("accentPink")),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(AppColors.get("accentPink")),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeader(title: Labels.get("login")),
            ConstrainedBox(
                constraints: BoxConstraints(minHeight: _height * 0.55),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: FormLogin(
                    handleSubmit: _handleSubmit,
                    disableForm: _authService.isLoading,
                  ),
                )),
            Container(
              width: _width,
              height: 30,
              color: Color(AppColors.get("white92")),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 150,
              ),
              child: Container(
                width: _width,
                height: (_height * 0.45) - 150,
                color: Color(AppColors.get("darkBlue")),
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      Labels.get("notRegisteredYet"),
                      style: TextStyle(
                          fontSize: 16, color: Color(AppColors.get("white92"))),
                    ),
                    const CustomDivider(
                      height: 15,
                    ),
                    CustomButton(
                      onPressed: _navigateToRegister,
                      text: Labels.get("signUp"),
                      fontSize: 14,
                      disableButton: _authService.isLoading,
                      size: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
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

  void _navigateToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
