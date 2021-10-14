class ChangeUserDataModel {
  String appBarTitle;
  String optionTitle;
  String? regex;
  bool? requireReAuthenticate;

  ChangeUserDataModel(
      {required this.appBarTitle,
      required this.optionTitle,
      this.regex,
      this.requireReAuthenticate = false});
}
