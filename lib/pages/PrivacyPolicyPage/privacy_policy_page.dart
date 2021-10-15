import 'package:capyba_challenge_frontend/config/colors/colors.dart';
import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColors.get("accentPink")),
      appBar: AppBar(
        title: Text(
          Labels.get("privacyPolicy"),
        ),
        backgroundColor: Color(AppColors.get("darkBlue")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            Labels.get("terms"),
            style: TextStyle(
                color: Color(AppColors.get("lightGray")), fontSize: 16),
          ),
        ),
      ),
    );
  }
}
