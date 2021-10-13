import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final Icon? leftIcon;
  final Function? onPress;
  const CustomHeader(
      {Key? key, required this.title, this.leftIcon, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      alignment: Alignment.topCenter,
      color: const Color(0xfff05454),
      child: Stack(
        children: [
          (leftIcon != null && onPress != null)
              ? IconButton(
                  onPressed: () => onPress!(),
                  icon: leftIcon!,
                  color: Color(AppColors.get("white92")),
                )
              : Container(),
          Center(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 8),
              width: 135,
              height: 90,
              color: const Color(0xff222831),
              child: Text(
                title,
                style: TextStyle(
                    color: Color(AppColors.get("white92")), fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
