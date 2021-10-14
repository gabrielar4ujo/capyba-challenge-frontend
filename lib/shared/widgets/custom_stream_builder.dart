import 'package:capyba_challenge_frontend/shared/widgets/custom_list.dart';
import 'package:flutter/material.dart';

class CustomStreamBuilder extends StatelessWidget {
  final Function service;
  const CustomStreamBuilder({Key? key, required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: service(),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            List list = snapshot.data.docs;
            return CustomList(docs: list);
          case ConnectionState.done:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
