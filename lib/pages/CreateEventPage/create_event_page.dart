import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/services/event_service.dart';
import 'package:capyba_challenge_frontend/shared/constants/colors/colors.dart';
import 'package:capyba_challenge_frontend/shared/models/auth_exception_model.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_divider.dart';
import 'package:capyba_challenge_frontend/shared/widgets/global_snackbar.dart';
import 'package:capyba_challenge_frontend/shared/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  bool isSwitched = false;
  String _name = "";
  String _about = "";
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    final EventService _eventService = Provider.of<EventService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastre seu evento"),
        backgroundColor: Color(AppColors.get("darkBlue")),
      ),
      backgroundColor: Color(AppColors.get("accentPink")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputText(
                      disableInput: _eventService.isLoading,
                      title: Labels.get("name"),
                      onSaved: setName,
                      horizontalPadding: 14,
                      capitalization: TextCapitalization.words,
                    ),
                    const CustomDivider(),
                    InputText(
                      maxLines: 4,
                      disableInput: _eventService.isLoading,
                      title: "Sobre",
                      onSaved: setAbout,
                      horizontalPadding: 14,
                      capitalization: TextCapitalization.sentences,
                    ),
                  ],
                ),
              ),
              Switch(
                value: isSwitched,
                onChanged: _eventService.isLoading
                    ? (value) {}
                    : (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                activeTrackColor: Color(AppColors.get("darkBlue")),
                activeColor: Color(AppColors.get("lightGray")),
                inactiveThumbColor: Color(AppColors.get("lightGray")),
              ),
              Center(
                  child: CustomButton(
                loadingButton: _eventService.isLoading,
                onPressed: () async {
                  _formKey.currentState!.save();
                  try {
                    await _eventService.createEvent(
                        name: _name,
                        public: !isSwitched,
                        owner: _authService.user!.displayName.toString(),
                        about: _about);
                    GlobalSnackbar.buildErrorSnackbar(
                        context, "Evento criado com sucesso");
                    Navigator.of(context).pop();
                  } on FirebaseServicesException catch (e) {
                    GlobalSnackbar.buildErrorSnackbar(
                        context, Labels.get(e.code));
                  }
                },
                text: "Salvar evento",
                fontSize: 16,
                size: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              ))
            ],
          ),
        ),
      ),
    );
  }

  void setName(text) {
    _name = text;
  }

  void setAbout(text) {
    _about = text;
  }
}
