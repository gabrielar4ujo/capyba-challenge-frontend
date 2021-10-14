import 'package:flutter/services.dart';

class ChangeUserDataModel {
  String appBarTitle;
  String optionTitle;
  String? regex;
  bool? requireReAuthenticate;
  bool? hiddenText;
  TextCapitalization? textCapitalization;

  ChangeUserDataModel(
      {required this.appBarTitle,
      required this.optionTitle,
      this.regex,
      this.requireReAuthenticate = false,
      this.hiddenText = false,
      this.textCapitalization = TextCapitalization.none});
}
