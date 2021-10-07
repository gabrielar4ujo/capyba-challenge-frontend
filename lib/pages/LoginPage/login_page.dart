import 'package:capyba_challenge_frontend/locales/pt_br/labels.dart';
import 'package:capyba_challenge_frontend/pages/LoginPage/widgets/form_field.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_header.dart';
import 'package:capyba_challenge_frontend/shared/widgets/input_text.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xfff05454),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(0xfff05454),
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
              color: const Color(0xffdddddd),
            ),
            Container(
              width: _width,
              height: (_height * 0.45) - 30,
              color: const Color(0xff30475e),
            ),
          ],
        ),
      ),
    );
  }
}
