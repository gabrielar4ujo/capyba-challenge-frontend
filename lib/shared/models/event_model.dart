class Event {
  String _name = "";
  String _about = "";
  String _owner = "";
  bool _public = false;

  Event(data) {
    _public = data["public"] ?? true;
    _name = data["eventName"] ?? "";
    _about = data["about"] ?? "";
    _owner = data["owner"] ?? "";
  }

  bool get public => _public;
  String get name => _name;
  String get about => _about;
  String get owner => _owner;
}
