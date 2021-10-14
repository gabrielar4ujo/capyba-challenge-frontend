import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/pages/TabPage/widgets/item_drawer.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_fade_image.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<dynamic> items;
  final Function onPressExit;
  final String? photoUrl;
  const CustomDrawer(
      {Key? key,
      required this.items,
      required this.onPressExit,
      required this.photoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        child: Container(
          color: Color(AppColors.get("accentPink")),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(AppColors.get("darkBlue")),
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 140,
                      width: 140,
                      child: photoUrl != null
                          ? ClipOval(
                              child: CustomFadeImage(url: photoUrl.toString()))
                          : Container(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(items.length, (i) {
                      return ItemDrawer(
                          title: items[i]["name"], onTap: items[i]["onPress"]);
                    }),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  text: Labels.get("logout"),
                  onPressed: onPressExit,
                  size: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  fontSize: 15,
                  borderColor: "lightGray",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
