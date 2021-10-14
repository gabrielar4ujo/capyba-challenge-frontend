import 'dart:io';

import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/shared/camera/camera.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/models/auth_exception_model.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_divider.dart';
import 'package:capyba_challenge_frontend/shared/widgets/global_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeUserPhotoPage extends StatefulWidget {
  final dynamic handleService;
  const ChangeUserPhotoPage({Key? key, required this.handleService})
      : super(key: key);

  @override
  _ChangeUserPhotoPageState createState() => _ChangeUserPhotoPageState();
}

class _ChangeUserPhotoPageState extends State<ChangeUserPhotoPage> {
  final Camera _camera = Camera();
  @override
  Widget build(BuildContext context) {
    final double photoSize = MediaQuery.of(context).size.width * 0.65;
    final AuthService _authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Color(AppColors.get("accentPink")),
      appBar: AppBar(
        backgroundColor: Color(AppColors.get("darkBlue")),
        title: Text(
          Labels.get("changePhoto"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _camera.image != null && !_authService.isLoading
                ? () async {
                    try {
                      await widget.handleService(File(_camera.image!.path));
                      Navigator.of(context).pop();
                    } on AuthException catch (e) {
                      GlobalSnackbar.buildErrorSnackbar(
                          context, Labels.get(e.code));
                    }
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
                Labels.get("takeNewPhoto"),
                style: TextStyle(
                    color: Color(AppColors.get("darkBlue")),
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              const CustomDivider(
                height: 40,
              ),
              SizedBox(
                width: photoSize,
                height: photoSize,
                child: ClipOval(
                  child: _camera.image == null
                      ? FadeInImage.assetNetwork(
                          image: _authService.user!.photoURL.toString(),
                          fit: BoxFit.cover,
                          placeholder: "assets/gifs/loading.gif",
                        )
                      : Image.file(File(_camera.image!.path)),
                ),
              ),
              const CustomDivider(
                height: 60,
              ),
              CustomButton(
                loadingButton: _authService.isLoading,
                text: Labels.get(
                    _camera.image == null ? "takePhoto" : "takeAnotherPhoto"),
                onPressed: () async {
                  await _camera.takePicture();
                  setState(() {});
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
