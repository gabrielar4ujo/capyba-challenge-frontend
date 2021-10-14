import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_fade_image.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<dynamic> items;
  final Function onPressExit;
  final String photoUrl;
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
              ListView.builder(
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? SizedBox(
                          height: 200,
                          child: DrawerHeader(
                            decoration: BoxDecoration(
                              color: Color(AppColors.get("darkBlue")),
                            ),
                            child: Center(
                              child: SizedBox(
                                height: 140,
                                width: 140,
                                child: ClipOval(
                                    child: CustomFadeImage(url: photoUrl)),
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            ListTile(
                              title: _optionTile(items[index - 1]["name"]),
                              onTap: items[index - 1]["onPress"],
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 0.5,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.5),
                              color: Color(AppColors.get("darkBlue")),
                            )
                          ],
                        );
                },
                padding: EdgeInsets.zero,
                shrinkWrap: true,
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    text: Labels.get("logout"),
                    onPressed: onPressExit,
                    size:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    fontSize: 15,
                    borderColor: "lightGray",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _optionTile(text) {
    return Text(
      text,
      style: TextStyle(color: Color(AppColors.get("lightGray")), fontSize: 17),
    );
  }
}
