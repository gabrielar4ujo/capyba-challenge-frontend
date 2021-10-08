class TextValidator {

  bool emailIsValid(text) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(text.toString());
  
  bool textIsNotEmpty(text) {
    final _text = text.toString();
    return !(_text.isEmpty || _text.trim() == "");
  }
}
