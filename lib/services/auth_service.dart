import 'package:capyba_challenge_frontend/services/storage_service.dart';
import 'package:capyba_challenge_frontend/shared/models/auth_exception_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageService _storageService = StorageService();
  User? _user;
  bool _isLoading = false;

  AuthService() {
    _getUser();
    reloadUser();
  }

  bool get hasUser => _user != null;
  bool get isLoading => _isLoading;
  bool get emailVerified => _user != null && _user!.emailVerified;
  String? get photoUrl => _user != null ? _user!.photoURL.toString() : null;
  String? get email => _user != null ? _user!.email.toString() : null;
  String? get displayName =>
      _user != null ? _user!.displayName.toString() : null;

  void _getUser() {
    _user = _auth.currentUser;
    notifyListeners();
  }

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _resetLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(
      String email, String senha, File _image, String _name) async {
    try {
      _setLoading();
      UserCredential result = await _auth
          .createUserWithEmailAndPassword(email: email, password: senha)
          .timeout(const Duration(seconds: 25), onTimeout: () {
        throw FirebaseAuthException(code: 'network-error');
      });
      User? localUser = result.user;
      if (localUser == null) throw FirebaseAuthException(code: "network-error");
      String? photoUrl =
          await _storageService.uploadFile(_image, localUser.uid);
      await localUser.updateDisplayName(_name);
      if (photoUrl != null) await localUser.updatePhotoURL(photoUrl);
      _getUser();
    } on FirebaseAuthException catch (e) {
      throw FirebaseServicesException(e.code);
    } finally {
      _resetLoading();
    }
  }

  Future<void> login(String email, String senha) async {
    try {
      _setLoading();
      UserCredential result = await _auth
          .signInWithEmailAndPassword(email: email, password: senha)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        throw FirebaseAuthException(code: 'network-error');
      });
      if (result.user == null) {
        throw FirebaseAuthException(code: "network-error");
      }
      _getUser();
    } on FirebaseAuthException catch (e) {
      throw FirebaseServicesException(e.code);
    } finally {
      _resetLoading();
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _getUser();
    } on FirebaseAuthException catch (e) {
      throw FirebaseServicesException(e.code);
    }
  }

  Future<void> reloadUser() async {
    try {
      if (_auth.currentUser == null) return;
      await _auth.currentUser!.reload();
      _getUser();
    } on FirebaseAuthException catch (e) {
      throw FirebaseServicesException(e.code);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw FirebaseServicesException(e.code);
    }
  }

  Future<void> updatePhotoURL(File? file) async {
    try {
      _setLoading();
      String? photoUrl = await _storageService
          .uploadFile(file, _user!.uid)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        throw FirebaseAuthException(code: 'network-error');
      });
      if (photoUrl == null) {
        throw FirebaseServicesException("upload-file-error");
      }
      await _user!.updatePhotoURL(photoUrl);
      await reloadUser();
    } on FirebaseAuthException catch (e) {
      throw FirebaseServicesException(e.code);
    } finally {
      _resetLoading();
    }
  }

  Future<void> changeUserName(_newName) async {
    try {
      _setLoading();
      await _user!.updateDisplayName(_newName);
      await reloadUser();
    } on FirebaseAuthException catch (e) {
      throw FirebaseServicesException(e.code);
    } finally {
      _resetLoading();
    }
  }

  Future<void> changeUserEmail(_newEmail, _oldEmail, _currentPassword) async {
    try {
      _setLoading();
      UserCredential localUser =
          await reAuthenticate(_oldEmail, _currentPassword);
      await localUser.user!.updateEmail(_newEmail);
      await reloadUser();
    } on FirebaseAuthException catch (e) {
      throw FirebaseServicesException(e.code);
    } finally {
      _resetLoading();
    }
  }

  Future<void> changeUserPassword(
      _newPassword, _currentEmail, _oldPassword) async {
    try {
      _setLoading();
      UserCredential localUser =
          await reAuthenticate(_currentEmail, _oldPassword);
      await localUser.user!.updatePassword(_newPassword);
      await reloadUser();
    } on FirebaseAuthException catch (e) {
      throw FirebaseServicesException(e.code);
    } finally {
      _resetLoading();
    }
  }

  Future<UserCredential> reAuthenticate(_email_, password) async {
    return await _user!.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: _email_, password: password));
  }
}
