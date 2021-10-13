import 'dart:io';

import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/shared/camera/camera.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeUserPhotoPage extends StatefulWidget {
  const ChangeUserPhotoPage({Key? key}) : super(key: key);

  @override
  _ChangeUserPhotoPageState createState() => _ChangeUserPhotoPageState();
}

class _ChangeUserPhotoPageState extends State<ChangeUserPhotoPage> {
  final Camera _camera = Camera();
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Color(AppColors.get("accentPink")),
      appBar: AppBar(
        backgroundColor: Color(AppColors.get("darkBlue")),
        title: const Text(
          "Alterar foto",
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _camera.image != null && !_authService.isLoading
                ? () async {
                    await _authService
                        .updatePhotoURL(File(_camera.image!.path));
                    Navigator.of(context).pop();
                  }
                : null,
            disabledColor: Colors.white12,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tire uma nova foto",
                style: TextStyle(
                    color: Color(AppColors.get("darkBlue")),
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              const CustomDivider(
                height: 40,
              ),
              ClipOval(
                child: _camera.image == null
                    ? Image.network(
                        _authService.user!.photoURL.toString(),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : Image.file(File(_camera.image!.path)),
              ),
              const CustomDivider(
                height: 60,
              ),
              CustomButton(
                loadingButton: _authService.isLoading,
                text: _camera.image == null ? "Tirar foto" : "Tirar outra foto",
                onPressed: () async {
                  await _camera.takePicture();
                  setState(() {});
                  // Navigator.of(context).pop();
                },
                size: const EdgeInsets.symmetric(horizontal: 10),
                fontSize: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
