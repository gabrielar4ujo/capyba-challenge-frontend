import 'package:capyba_challenge_frontend/pages/ProfilePage/widgets/custom_tile.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
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
      {"title": "Nome", "onPress": () {}},
      {"title": "Email", "onPress": () {}},
      {"title": "Foto", "onPress": () {}, "photo": _authService.user!.photoURL},
      {"title": "Senha", "onPress": () {}},
    ];
    print(_authService.user!.photoURL);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(AppColors.get("darkBlue")),
        title: const Text("Meu perfil"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dados pessoais",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: mappingOptions.length,
                  itemBuilder: (context, index) {
                    return CustomTile(
                      title: mappingOptions[index]["title"].toString(),
                      photo: mappingOptions[index].containsKey("photo")
                          ? mappingOptions[index]["photo"].toString()
                          : null,
                    );
                  }),
            )
          ],
        ),
      ),
      backgroundColor: Color(AppColors.get("accentPink")),
    );
  }

  // void _showSnackBar(String text) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  // }
}
