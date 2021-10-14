import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/services/event_service.dart';
import 'package:capyba_challenge_frontend/shared/models/auth_exception_model.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_button.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_stream_builder.dart';
import 'package:capyba_challenge_frontend/shared/widgets/global_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestrictedPage extends StatefulWidget {
  const RestrictedPage({Key? key}) : super(key: key);

  @override
  _RestrictedPageState createState() => _RestrictedPageState();
}

class _RestrictedPageState extends State<RestrictedPage> {
  @override
  Widget build(BuildContext context) {
    final EventService _eventService = Provider.of<EventService>(context);
    final AuthService _authService = Provider.of<AuthService>(context);
    return _authService.user!.emailVerified
        ? CustomStreamBuilder(
            service: _eventService.getPrivateEvents,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Restrito: Está restrito? R: ${_authService.emailVerified() ? 'Não' : 'Sim'}',
              ),
              CustomButton(
                onPressed: () async {
                  try {
                    await _authService.reloadUser();
                  } on AuthException catch (e) {
                    GlobalSnackbar.buildErrorSnackbar(
                        context, Labels.get(e.code));
                  }
                },
                text: "Já validei meu email",
              )
            ],
          );
  }
}
