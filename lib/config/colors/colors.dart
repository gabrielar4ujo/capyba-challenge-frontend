import 'package:capyba_challenge_frontend/config/colors/_default_colors.dart';

class AppColors {
  static int get(String colorName) {
    return int.parse(colors[colorName].toString());
  }
}
