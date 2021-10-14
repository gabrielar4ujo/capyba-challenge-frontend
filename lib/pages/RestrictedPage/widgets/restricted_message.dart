import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class RestrictedMessage extends StatelessWidget {
  final Function reloadUser;
  const RestrictedMessage({Key? key, required this.reloadUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock,
            size: 70,
            color: Color(AppColors.get("darkBlue")),
          ),
          const CustomDivider(),
          Text(
            'Está área é restrita para os emails que ainda não foram verificados.\nAcesse o menu lateral e valide seu email!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(AppColors.get("darkBlue"))),
          ),
          const CustomDivider(),
          CustomButton(
            onPressed: reloadUser,
            text: "Já validei meu email",
          )
        ],
      ),
    );
  }
}
