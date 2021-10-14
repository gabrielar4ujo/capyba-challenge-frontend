class Event {
  String _name = "";
  bool _public = false;

  Event(name, public) {
    _public = public;
    _name = name;
  }

  bool get public => _public;
  String get name => _name;
}
