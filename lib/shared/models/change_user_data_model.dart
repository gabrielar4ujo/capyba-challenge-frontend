class ChangeUserDataModel {
  String appBarTitle;
  String header;
  String optionTitle;
  String? regex;
  bool? requireReAuthenticate;

  ChangeUserDataModel(
      {required this.appBarTitle,
      required this.header,
      required this.optionTitle,
      this.regex,
      this.requireReAuthenticate = false});
}
