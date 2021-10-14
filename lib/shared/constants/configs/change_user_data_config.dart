import 'package:capyba_challenge_frontend/shared/constants/regex/regex.dart';
import 'package:capyba_challenge_frontend/shared/models/change_user_data_model.dart';
import 'package:flutter/cupertino.dart';

enum EnumChangeUserDataConfig {
  changeName,
  changePhoto,
  changeEmail,
  changePassword
}

class ChangeUserDataConfig {
  final Regex _regex = Regex();
  EnumChangeUserDataConfig config;

  ChangeUserDataConfig(this.config);

  ChangeUserDataModel getConfig() {
    switch (config) {
      case EnumChangeUserDataConfig.changeName:
        return ChangeUserDataModel(
            appBarTitle: "Alterar nome",
            optionTitle: "Nome",
            textCapitalization: TextCapitalization.words);
      case EnumChangeUserDataConfig.changeEmail:
        return ChangeUserDataModel(
            appBarTitle: "Alterar email",
            optionTitle: "Novo email",
            regex: _regex.emailRegex,
            requireReAuthenticate: true);
      case EnumChangeUserDataConfig.changePassword:
        return ChangeUserDataModel(
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
