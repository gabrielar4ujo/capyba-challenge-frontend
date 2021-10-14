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
  }

  User? get user => _user;

  bool get isLoading => _isLoading;

  bool emailVerified() {
    return user != null && user!.emailVerified;
  }

  void _getUser() {
    _user = _auth.currentUser;
    notifyListeners();
  }

  Future<void> signUp(
      String email, String senha, File _image, String _name) async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      User? localUser = result.user!;
      if (localUser == null) throw FirebaseAuthException(code: "Network-error");
      String? photoUrl =
          await _storageService.uploadFile(_image, localUser.uid);
      if (photoUrl == null) {
        throw FirebaseAuthException(code: "unknown-error");
      }
      await localUser.updateDisplayName(_name);
      await localUser.updatePhotoURL(photoUrl);
      _getUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String senha) async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: senha);
      if (result.user == null) {
        throw FirebaseAuthException(code: "Network-error");
      }
      _getUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _getUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    }
  }

  Future<void> reloadUser() async {
    try {
      await _auth.currentUser!.reload();
      _getUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    }
  }

  Future<void> updatePhotoURL(File? file) async {
    try {
      _isLoading = true;
      notifyListeners();
      String? photoUrl = await _storageService.uploadFile(file, user!.uid);
      if (photoUrl == null) {
        throw AuthException("error-upload-image");
      }
      await user!.updatePhotoURL(photoUrl);
      reloadUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changeUserName(_newName) async {
    try {
      _isLoading = true;
      notifyListeners();
      await user!.updateDisplayName(_newName);
      reloadUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changeUserEmail(_newEmail, _oldEmail, _currentPassword) async {
    try {
      await login(_oldEmail, _currentPassword);
      _isLoading = true;
      notifyListeners();
      await user!.updateEmail(_newEmail);
      reloadUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changeUserPassword(
      _newPassword, _currentEmail, _oldPassword) async {
    try {
      await login(_currentEmail, _oldPassword);
      _isLoading = true;
      notifyListeners();
      await user!.updatePassword(_newPassword);
      reloadUser();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
