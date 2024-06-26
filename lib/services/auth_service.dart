import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  AuthService() {
    _firebaseAuth.authStateChanges().listen(authStatesChangesStreamListenner);
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? _user;

  User? get user => _user;

  Future<bool> register({required String email, required String password}) async {
    try {
      final UserCredential credentials =
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (credentials.user != null) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      final UserCredential credentials =
          await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (credentials.user != null) {
        _user = credentials.user;
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  void authStatesChangesStreamListenner(User? user) {
    if (user != null) {
      _user = user;
    } else {
      _user = null;
    }
  }
}
