import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as io;

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = false;

  AuthService() {
    _getUser();
  }

  _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  signUp(String email, String senha, io.File _image, String _name) async {
    try {
      isLoading = true;
      notifyListeners();
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      User localUser = result.user!;
      if (localUser == null) throw FirebaseAuthException(code: "Network-error");
      String? photoUrl = await uploadFile(_image, localUser.uid);
      if (photoUrl == null) {
        throw FirebaseAuthException(code: "Problema ao fazer upload de imagem");
      }
      print(photoUrl);
      await localUser.updateDisplayName(_name);
      await localUser.updatePhotoURL(photoUrl);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      }
      throw AuthException(e.code);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  login(String email, String senha) async {
    try {
      isLoading = true;
      notifyListeners();
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: senha);
      if (result.user == null) {
        throw FirebaseAuthException(code: "Network-error");
      }
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
      throw AuthException(e.code);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }

  reloadUser() async {
    await _auth.currentUser!.reload();
    _getUser();
  }

  bool emailVerified() {
    return user != null && user!.emailVerified;
  }

  Future<void> sendEmailVerification() async {
    try {
      await user!.sendEmailVerification();
    } catch (e) {
      throw AuthException("Erro ao mandar email de verificação!");
    }
  }

  Future<String?> uploadFile(io.File? file, String fileName) async {
    if (file == null) {
      return null;
    }

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('usersPhoto')
        .child('/$fileName.jpg');

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    UploadTask uploadTask = ref.putFile(io.File(file.path), metadata);
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }
}
