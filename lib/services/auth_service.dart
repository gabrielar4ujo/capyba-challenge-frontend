import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = false;

  AuthService() {
    _authCheck();
    _getUser();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      user = (user == null) ? null : user;
      notifyListeners();
    });
  }

  _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  signUp(String email, String senha, String _image, String _name) async {
    try {
      isLoading = true;
      notifyListeners();
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      User localUser = result.user!;
      await localUser.updateDisplayName(_name);
      await localUser.updatePhotoURL(_image);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  login(String email, String senha) async {
    try {
      isLoading = true;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
