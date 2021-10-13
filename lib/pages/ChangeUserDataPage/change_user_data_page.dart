import 'package:flutter/material.dart';

class ChangeUserDataPage extends StatefulWidget {
  const ChangeUserDataPage({Key? key}) : super(key: key);

  @override
  _ChangeUserDataPageState createState() => _ChangeUserDataPageState();
}

class _ChangeUserDataPageState extends State<ChangeUserDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alterar algo"),
      ),
    );
  }
}
