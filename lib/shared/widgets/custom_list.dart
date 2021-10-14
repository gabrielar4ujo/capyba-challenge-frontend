import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/models/event_model.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_divider.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_expansion_tile.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final List docs;
  const CustomList({Key? key, required this.docs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return docs.isEmpty
        ? Center(
            child: Text(
              "Sem eventos para listar :(",
              style: TextStyle(
                  fontSize: 18, color: Color(AppColors.get("darkBlue"))),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            itemCount: docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  CustomExpansionTile(
                    event: Event(docs[index].data()),
                  ),
                  const CustomDivider(
                    height: 10,
                  ),
                ],
              );
            });
  }
}
