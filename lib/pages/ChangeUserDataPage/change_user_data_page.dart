import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/constants/configs/change_user_data_config.dart';
import 'package:capyba_challenge_frontend/shared/constants/regex/regex.dart';
import 'package:capyba_challenge_frontend/shared/models/auth_exception_model.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_divider.dart';
import 'package:capyba_challenge_frontend/shared/widgets/global_snackbar.dart';
import 'package:capyba_challenge_frontend/shared/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChangeUserDataPage extends StatefulWidget {
  final EnumChangeUserDataConfig config;
  final dynamic handleFunction;
  const ChangeUserDataPage(
      {Key? key, required this.config, required this.handleFunction})
      : super(key: key);

  @override
  _ChangeUserDataPageState createState() => _ChangeUserDataPageState();
}

class _ChangeUserDataPageState extends State<ChangeUserDataPage> {
  String _newField = "";
  String _currentEmail = "";
  String _currentPassword = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    final ChangeUserDataConfig _changeUserDataConfig =
        ChangeUserDataConfig(widget.config);
    Future<bool> _willPopCallback() async {
      return Future.value(!_authService.isLoading);
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Color(AppColors.get("accentPink")),
        appBar: AppBar(
          backgroundColor: Color(AppColors.get("darkBlue")),
          title: Text(
            _changeUserDataConfig.getConfig().appBarTitle,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Labels.get("fillTheFields"),
                  style: TextStyle(
                      color: Color(AppColors.get("darkBlue")),
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
                const CustomDivider(
                  height: 40,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _changeUserDataConfig.getConfig().requireReAuthenticate ==
                              true
                          ? Column(
                              children: [
                                InputText(
                                    disableInput: _authService.isLoading,
                                    formatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(Regex().emailRegex)),
                                    ],
                                    horizontalPadding: 0,
                                    title: Labels.get("currentEmail"),
                                    onSaved: setCurrentEmail),
                                InputText(
                                    hiddenText: true,
                                    disableInput: _authService.isLoading,
                                    horizontalPadding: 0,
                                    title: Labels.get("currentPassword"),
                                    onSaved: setCurrentPassword),
                              ],
                            )
                          : Container(),
                      InputText(
                          formatter: [
                            _changeUserDataConfig.getConfig().regex != null
                                ? FilteringTextInputFormatter.allow(RegExp(
                                    _changeUserDataConfig
                                        .getConfig()
                                        .regex
                                        .toString()))
                                : FilteringTextInputFormatter
                                    .singleLineFormatter
                          ],
                          hiddenText:
                              _changeUserDataConfig.getConfig().hiddenText!,
                          capitalization: _changeUserDataConfig
                              .getConfig()
                              .textCapitalization,
                          disableInput: _authService.isLoading,
                          horizontalPadding: 0,
                          title: _changeUserDataConfig.getConfig().optionTitle,
                          onSaved: setField),
                    ],
                  ),
                ),
                const CustomDivider(
                  height: 60,
                ),
                CustomButton(
                  loadingButton: _authService.isLoading,
                  text: Labels.get("saveEditions"),
                  onPressed: () async {
                    _formKey.currentState!.save();
                    try {
                      _changeUserDataConfig.getConfig().requireReAuthenticate ==
                              true
                          ? await widget.handleFunction(
                              _newField, _currentEmail, _currentPassword)
                          : await widget.handleFunction(_newField);
                      Navigator.of(context).pop();
                    } on FirebaseServicesException catch (e) {
                      GlobalSnackbar.buildErrorSnackbar(
                          context, Labels.get(e.code));
                    }
                  },
                  size: const EdgeInsets.symmetric(horizontal: 10),
                  fontSize: 14,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setField(text) {
    _newField = text;
  }

  void setCurrentEmail(text) {
    _currentEmail = text;
  }

  void setCurrentPassword(text) {
    _currentPassword = text;
  }
}
