import 'package:capyba_challenge_frontend/pages/ChangeUserDataPage/configs/change_user_data_config.dart';

class UserDataModel {
  String title;
  String? subtitle;
  String? photo;
  EnumChangeUserDataConfig? configName;
  Function({EnumChangeUserDataConfig? conf, dynamic func}) onTap;
  dynamic handleService;

  UserDataModel(
      {required this.onTap,
      this.photo,
      required this.title,
      this.subtitle,
      required this.handleService,
      required this.configName});

  void navigate() {
    onTap(conf: configName, func: handleService);
  }
}
