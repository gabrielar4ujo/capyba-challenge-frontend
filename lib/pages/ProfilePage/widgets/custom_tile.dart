import 'dart:io';

import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String? photo;
  const CustomTile({Key? key, required this.title, this.photo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          trailing: InkWell(
            child: Container(
                width: 66,
                alignment: Alignment.centerRight,
                child: Row(
                  children: const [
                    Text("Alterar"),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                )),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              photo != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomDivider(
                          height: 10,
                        ),
                        Image.network(
                          photo.toString(),
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
          height: photo == null ? 1 : 0,
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
