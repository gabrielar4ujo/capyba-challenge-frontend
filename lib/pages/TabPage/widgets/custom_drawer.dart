import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<dynamic> items;
  final Function onPressExit;
  const CustomDrawer({Key? key, required this.items, required this.onPressExit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
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
                          height: 125,
                          child: DrawerHeader(
                            decoration: BoxDecoration(
                              color: Color(AppColors.get("darkBlue")),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        )
                      : ListTile(
                          title: _optionTile(items[index - 1]["name"]),
                          onTap: items[index - 1]["onPress"],
                        );
                },
                padding: EdgeInsets.zero,
                shrinkWrap: true,
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    text: 'Sair da conta',
                    onPressed: onPressExit,
                    size:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    fontSize: 15,
                    borderColor: "white92",
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
      style: TextStyle(color: Color(AppColors.get("white92"))),
    );
  }
}
