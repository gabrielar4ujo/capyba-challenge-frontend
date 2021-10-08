class AppColors {
  final Map<String,String> _colors = {
    "white92": "0xffdddddd",
    "accentPink": "0xfff05454",
    "darkBlue": "0xff30475e",
    "mediumBlack": "0xff222831"
  };

  int get(String colorName) => int.parse(_colors[colorName].toString());
} 