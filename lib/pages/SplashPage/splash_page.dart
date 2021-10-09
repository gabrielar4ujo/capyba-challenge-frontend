import 'package:capyba_challenge_frontend/pages/HomePage/home_page.dart';
import 'package:capyba_challenge_frontend/pages/LoginPage/login_page.dart';
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
  final AppColors _appColors = AppColors();
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
    return Container(
      color: Color(_appColors.get("accentPink")),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
