import 'package:capyba_challenge_frontend/locales/labels.dart';
import 'package:capyba_challenge_frontend/pages/RestrictedPage/widgets/restricted_message.dart';
import 'package:capyba_challenge_frontend/services/auth_service.dart';
import 'package:capyba_challenge_frontend/services/event_service.dart';
import 'package:capyba_challenge_frontend/shared/models/auth_exception_model.dart';
import 'package:capyba_challenge_frontend/shared/widgets/custom_stream_builder.dart';
import 'package:capyba_challenge_frontend/utils/global_snackbar.dart';
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
    Future _reloadUser() async {
      try {
        await _authService.reloadUser();
        if (_authService.emailVerified()) {
          GlobalSnackbar.showMessage(
              context, Labels.get("emailHasBeenVerified"));
        } else {
          GlobalSnackbar.showMessage(
              context, Labels.get("emailNotYetVerified"));
        }
      } on FirebaseServicesException catch (e) {
        GlobalSnackbar.showMessage(context, Labels.get(e.code));
      }
    }

    return _authService.emailVerified()
        ? CustomStreamBuilder(
            service: _eventService.getPrivateEvents,
          )
        : SingleChildScrollView(
            child: RestrictedMessage(
              reloadUser: _reloadUser,
            ),
          );
  }
}
