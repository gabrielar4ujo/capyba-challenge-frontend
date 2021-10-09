import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/pages/HomePage/home_page.dart';
import 'package:capyba_challenge_frontend/pages/RegisterPage/widgets/form_register.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _statusBarHeight = MediaQuery.of(context).padding.top;
    final _appBarHeight = AppBar().preferredSize.height;
    AuthService _authService = Provider.of<AuthService>(context);
    _handleSubmit(
        String email, String senha, String _image, String _name) async {
      await _authService.signUp(email, senha, _image, _name);
      _navigateToHomePage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Labels.get("signUp")),
        backgroundColor: Color(AppColors.get("darkBlue")),
      ),
      backgroundColor: Color(AppColors.get("accentPink")),
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
                color: Color(AppColors.get("darkBlue"))),
            constraints: const BoxConstraints(minHeight: 500, maxHeight: 570),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: FormRegister(
              handleSubmit: _handleSubmit,
              disableForm: _authService.isLoading,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToHomePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false,
    );
  }
}
