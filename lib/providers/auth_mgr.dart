import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const adminsCollection = 'admins';

enum ApplicationLoginState {
  loggedOut,
  loggedIn,
  mobileAuth,
}

class AuthenticationMgr extends ChangeNotifier {
  final FirebaseAuth _fa = FirebaseAuth.instance;
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  AuthenticationMgr() {
    init();
  }

  Future<void> init() async {
    _fa.userChanges().listen((user) {
      if (user != null) {
        _authState = ApplicationLoginState.loggedIn;
      } else {
        _authState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _authState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _authState;

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    verificationCompleted,
    verificationFailed,
    codeSent,
    codeAutoRetrievalTimeout,
  }) async {
    await _fa.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<bool> checkIfAdmin(String email) async {
    /// Check if the provided email is admin or not
    /// MMust be part of admins collections and registered as doc
    try {
      bool exist = false;
      await _fs.collection(adminsCollection).doc(email).get().then((doc) => {
            exist = doc.exists,
          });
      return exist;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendPasswordResetEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await _fa.sendPasswordResetEmail(
        email: email,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
      return false;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      final user = await _fa.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
    return null;
  }

  Future<UserCredential?> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      UserCredential user = await _fa.createUserWithEmailAndPassword(
          email: email, password: password);
      await user.user!.updateDisplayName(displayName);
      return user;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
    return null;
  }

  Future<UserCredential?> linkPhoneNumber(AuthCredential credential,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      UserCredential? user =
          await _fa.currentUser?.linkWithCredential(credential);
      return user;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
    return null;
  }

  void signOut() {
    _fa.signOut();
  }
}
