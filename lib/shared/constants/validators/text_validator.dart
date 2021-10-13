import 'package:capyba_challenge_frontend/locales/labels.dart';

class TextValidator {
  String? emailIsValid(text) {
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(text.toString())
        ? null
        : Labels.get("invalidEmail");
  }

  String? textIsNotEmpty(text) {
    final _text = text.toString();
    return _text.isEmpty || _text.trim() == ""
        ? Labels.get("requiredField")
        : null;
  }

  String? strongPassword(text) {
    final _text = text.toString();
    String? result = textIsNotEmpty(_text);
    if (result != null) return result;
    return _text.length >= 6 ? null : Labels.get("weekPassword");
  }
}
