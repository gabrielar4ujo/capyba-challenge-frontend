import 'package:capyba_challenge_frontend/config/colors/colors.dart';
import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/shared/models/user_data_model.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final UserDataModel userDataModel;
  const CustomTile({Key? key, required this.userDataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          subtitle: Text(
            userDataModel.subtitle != null
                ? userDataModel.subtitle.toString()
                : "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Color(AppColors.get("lightGray"))),
          ),
          trailing: InkWell(
            child: Container(
                width: 66,
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: userDataModel.navigate,
                  child: Row(
                    children: [
                      Text(
                        Labels.get("change"),
                        style:
                            TextStyle(color: Color(AppColors.get('darkBlue'))),
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          color: Color(AppColors.get('darkBlue')))
                    ],
                  ),
                )),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userDataModel.title,
                style: TextStyle(color: Color(AppColors.get('darkBlue'))),
              ),
              userDataModel.photo != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomDivider(
                          height: 10,
                        ),
                        Image.network(
                          userDataModel.photo.toString(),
                          height: 50,
                          width: 50,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        Container(
          height: userDataModel.photo == null ? 1 : 0,
          width: double.maxFinite,
          color: Color(AppColors.get('darkBlue')),
        ),
        const CustomDivider(
          height: 10,
        ),
      ],
    );
  }
}
