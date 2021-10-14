import 'package:capyba_challenge_frontend/shared/models/change_user_data_model.dart';
import 'package:capyba_challenge_frontend/utils/regex/regex.dart';
import 'package:capyba_challenge_frontend/utils/validators/text_validator.dart';
import 'package:flutter/cupertino.dart';

enum EnumChangeUserDataConfig {
  changeName,
  changePhoto,
  changeEmail,
  changePassword
}

class ChangeUserDataConfig {
  final Regex _regex = Regex();
  final TextValidator _textValidator = TextValidator();
  EnumChangeUserDataConfig config;

  ChangeUserDataConfig(this.config);

  ChangeUserDataModel getConfig() {
    switch (config) {
      case EnumChangeUserDataConfig.changeName:
        return ChangeUserDataModel(
            textValidator: _textValidator.textIsNotEmpty,
            appBarTitle: "Alterar nome",
            optionTitle: "Nome",
            textCapitalization: TextCapitalization.words);
      case EnumChangeUserDataConfig.changeEmail:
        return ChangeUserDataModel(
            textValidator: _textValidator.emailIsValid,
            appBarTitle: "Alterar email",
            optionTitle: "Novo email",
            regex: _regex.emailRegex,
            requireReAuthenticate: true);
      case EnumChangeUserDataConfig.changePassword:
        return ChangeUserDataModel(
            textValidator: _textValidator.strongPassword,
            appBarTitle: "Alterar senha",
            optionTitle: "Nova senha",
            hiddenText: true,
            requireReAuthenticate: true);
      case EnumChangeUserDataConfig.changePhoto:
        return ChangeUserDataModel(
            appBarTitle: "Alterar foto", optionTitle: "Foto");
    }
  }
}
