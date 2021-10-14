import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/pages/LoginPage/login_page.dart';
import 'package:capyba_challenge_frontend/pages/TabPage/tab_page.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AuthService _authService =
      _authService = Provider.of<AuthService>(context, listen: false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1));
      if (_authService.user != null) {
        _navigateToHome();
      } else {
        _navigateToLogin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        color: Color(AppColors.get("accentPink")),
        child: Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(AppColors.get("darkBlue"))),
          child: Text(
            Labels.get("appName"),
            style: TextStyle(
                color: Color(AppColors.get("lightGray")),
                fontSize: 45,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const TabPage()));
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
