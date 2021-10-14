import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class EventService extends ChangeNotifier {
  bool _isLoading = false;
  final FirebaseFirestore _collectionReference = FirebaseFirestore.instance;

  FirebaseFirestore get collectionReference => _collectionReference;

  bool get isLoading => _isLoading;

  Future createPublicEvent(_name, _public) async {
    await _collectionReference
        .collection("home")
        .add({"eventName": _name, "public": _public});
  }

  Future createPrivateEvent(_name, _public) async {
    await _collectionReference
        .collection("restricted")
        .add({"eventName": _name, "public": _public});
  }

  Future createEvent(_name, _public) async {
    try {
      _isLoading = true;
      notifyListeners();
      _public
          ? await createPublicEvent(_name, _public)
          : await createPrivateEvent(_name, _public);
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPublicEvents() {
    return _collectionReference.collection("home").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPrivateEvents() {
    return _collectionReference.collection("restricted").snapshots();
  }
}
