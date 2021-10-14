import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final List docs;
  const CustomList({Key? key, required this.docs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return docs.isEmpty
        ? const Center(
            child: Text("Sem eventos públicos para listar!"),
          )
        : ListView.builder(
            itemCount: docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(docs[index].data()['eventName']);
            });
  }
}
