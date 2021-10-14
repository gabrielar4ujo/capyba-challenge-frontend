class FirebaseServicesException implements Exception {
  String? code;
  final List<String> codes = [
    "email-already-in-use",
    "invalid-email",
    "user-not-found",
    "wrong-password",
    "too-many-requests",
    "network-error",
    "upload-file-error"
  ];
  FirebaseServicesException(String _code) {
    code = codes.contains(_code) ? _code : "unknown-error";
  }
}
