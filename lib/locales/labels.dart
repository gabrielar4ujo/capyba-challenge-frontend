import 'package:capyba_challenge_frontend/locales/pt_br/_errors.dart';
import 'package:capyba_challenge_frontend/locales/pt_br/_labels.dart';
import 'package:capyba_challenge_frontend/locales/pt_br/_pressables.dart';
import 'package:capyba_challenge_frontend/locales/pt_br/_validators.dart';

class LabelException implements Exception {
  String message;
  LabelException(this.message);
}

class Labels {
  static String get(key) {
    const allText = {...labels, ...errors, ...pressables, ...validators};
    String? label = allText[key];
    if (label == null) throw LabelException("String não pode ser null");
    return label;
  }
}
