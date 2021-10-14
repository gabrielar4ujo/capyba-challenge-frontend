import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:flutter/material.dart';

class ItemDrawer extends StatelessWidget {
  final String title;
  final Function onTap;
  const ItemDrawer({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          onTap: () => onTap(),
        ),
        Container(
          width: double.maxFinite,
          height: 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 15.5),
          color: Color(AppColors.get("darkBlue")),
        ),
      ],
    );
  }
}
