import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/pages/ChangeUserDataPage/change_user_data_page.dart';
import 'package:capyba_challenge_frontend/pages/ChangeUserDataPage/configs/change_user_data_config.dart';
import 'package:capyba_challenge_frontend/pages/ChangeUserPhotoPage/change_user_photo_page.dart';
import 'package:capyba_challenge_frontend/pages/ProfilePage/widgets/custom_tile.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/models/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    final mappingOptions = [
      UserDataModel(
          onTap: _navigateToChangeUserData,
          title: Labels.get("name"),
          subtitle: _authService.displayName.toString(),
          configName: EnumChangeUserDataConfig.changeName,
          handleService: _authService.changeUserName),
      UserDataModel(
          onTap: _navigateToChangeUserData,
          title: Labels.get("email"),
          subtitle: _authService.email.toString(),
          configName: EnumChangeUserDataConfig.changeEmail,
          handleService: _authService.changeUserEmail),
      UserDataModel(
          onTap: _navigateToChangeUserPhoto,
          title: Labels.get("photo"),
          subtitle: Labels.get("seeYourPhoto"),
          configName: EnumChangeUserDataConfig.changePhoto,
          handleService: _authService.updatePhotoURL),
      UserDataModel(
          onTap: _navigateToChangeUserData,
          title: Labels.get("password"),
          subtitle: Labels.get("obscurePassword"),
          configName: EnumChangeUserDataConfig.changePassword,
          handleService: _authService.changeUserPassword),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(AppColors.get("darkBlue")),
        title: Text(
          "Meu perfil",
          style: TextStyle(color: Color(AppColors.get("lightGray"))),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Labels.get("personalData"),
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(AppColors.get("darkBlue"))),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: mappingOptions.length,
                  itemBuilder: (context, index) {
                    return CustomTile(userDataModel: mappingOptions[index]);
                  }),
            )
          ],
        ),
      ),
      backgroundColor: Color(AppColors.get("accentPink")),
    );
  }

  void _navigateToChangeUserData(
      {EnumChangeUserDataConfig? conf, dynamic func}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ChangeUserDataPage(config: conf!, handleFunction: func)));
  }

  void _navigateToChangeUserPhoto(
      {EnumChangeUserDataConfig? conf, dynamic func}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeUserPhotoPage(handleService: func)));
  }
}
