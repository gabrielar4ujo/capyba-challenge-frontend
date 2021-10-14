import 'package:capyba_challenge_frontend/utils/validators/text_validator.dart';
import 'package:flutter/services.dart';

class ChangeUserDataModel {
  String appBarTitle;
  String optionTitle;
  String? regex;
  bool? requireReAuthenticate;
  bool? hiddenText;
  TextCapitalization? textCapitalization;
  Function(String)? textValidator;

  ChangeUserDataModel(
      {required this.appBarTitle,
      required this.optionTitle,
      this.regex,
      this.requireReAuthenticate = false,
      this.hiddenText = false,
      this.textValidator,
      this.textCapitalization = TextCapitalization.none});
}
