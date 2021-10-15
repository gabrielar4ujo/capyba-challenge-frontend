import 'package:capyba_challenge_frontend/shared/models/auth_exception_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class EventService extends ChangeNotifier {
  bool _isLoading = false;
  final FirebaseFirestore _collectionReference = FirebaseFirestore.instance;

  FirebaseFirestore get collectionReference => _collectionReference;

  bool get isLoading => _isLoading;

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _resetLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future createPublicEvent(_name, _public, _about, _owner) async {
    await _collectionReference.collection("home").add({
      "eventName": _name,
      "public": _public,
      "about": _about,
      "owner": _owner,
      "createdAt": FieldValue.serverTimestamp()
    });
  }

  Future createPrivateEvent(_name, _public, _about, _owner) async {
    await _collectionReference.collection("restricted").add({
      "eventName": _name,
      "public": _public,
      "about": _about,
      "owner": _owner,
      "createdAt": FieldValue.serverTimestamp()
    });
  }

  Future createEvent(
      {required String name,
      required bool public,
      required String about,
      required String owner}) async {
    try {
      _setLoading();
      public
          ? await createPublicEvent(name, public, about, owner)
          : await createPrivateEvent(name, public, about, owner);
    } catch (e) {
      throw FirebaseServicesException("network-error");
    } finally {
      _resetLoading();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPublicEvents() {
    return _collectionReference
        .collection("home")
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPrivateEvents() {
    return _collectionReference
        .collection("restricted")
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
