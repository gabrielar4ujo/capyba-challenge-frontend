import 'package:capyba_challenge_frontend/shared/constants/colors/_default_colors.dart';

class AppColors {
  static int get(String colorName) {
    return int.parse(colors[colorName].toString());
  }
}
