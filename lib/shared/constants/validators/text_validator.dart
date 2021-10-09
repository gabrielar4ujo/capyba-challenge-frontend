class TextValidator {
  String? emailIsValid(text) {
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(text.toString())
        ? null
        : "Email inválido!";
  }

  String? textIsNotEmpty(text) {
    final _text = text.toString();
    return _text.isEmpty || _text.trim() == "" ? "Campo obrigatório!" : null;
  }

  String? strongPassword(text) {
    final _text = text.toString();
    String? result = textIsNotEmpty(_text);
    if (result != null) return result;
    return _text.length >= 6 ? null : "Senha fraca!";
  }
}
