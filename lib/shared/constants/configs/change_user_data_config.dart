import 'package:capyba_challenge_frontend/shared/constants/regex/regex.dart';
import 'package:capyba_challenge_frontend/shared/models/change_user_data_model.dart';

enum EnumChangeUserDataConfig {
  changeName,
  changePhoto,
  changeEmail,
  changePassword
}

class ChangeUserDataConfig {
  EnumChangeUserDataConfig config;

  ChangeUserDataConfig(this.config);

  ChangeUserDataModel getConfig() {
    switch (config) {
      case EnumChangeUserDataConfig.changeName:
        return ChangeUserDataModel(
            appBarTitle: "nome",
            header: "Digite um novo nome",
            optionTitle: "Nome");
      case EnumChangeUserDataConfig.changeEmail:
        return ChangeUserDataModel(
            appBarTitle: "email",
            header: "Digite um novo email",
            optionTitle: "Novo email",
            regex: Regex().emailRegex,
            requireReAuthenticate: true);
      case EnumChangeUserDataConfig.changePassword:
        return ChangeUserDataModel(
            appBarTitle: "senha",
            header: "Digite uma nova senha",
            optionTitle: "Nova senha",
            requireReAuthenticate: true);
      case EnumChangeUserDataConfig.changePhoto:
        return ChangeUserDataModel(
            appBarTitle: "foto",
            header: "Tire uma nova foto",
            optionTitle: "Foto");
    }
  }
}
