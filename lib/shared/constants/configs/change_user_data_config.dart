enum config { changeName, changePhoto, changeEmail, changePassword }

class ChangeUsarDataConfig {
  Model getConfig(conf) {
    switch (conf) {
      case config.changeName:
        return Model("nome", "Digite um novo nome", "Nome");
      case config.changeEmail:
        return Model("email", "Digite um novo email", "Email");
      case config.changePassword:
        return Model("senha", "Digite uma nova senha", "Senha");
      case config.changePhoto:
        return Model("foto", "Tire uma nova foto", "Foto");
      default:
        return Model("erro", "erro", "erro");
    }
  }
}

class Model {
  String appBarTitle;
  String header;
  String optionTitle;

  Model(this.appBarTitle, this.header, this.optionTitle);
}
