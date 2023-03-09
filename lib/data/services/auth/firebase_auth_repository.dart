import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class FirebaseAuthRepository {
  static FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;

  Future<User?> signUp(
      {required String email, required String password}) async {
    User? user;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) => user = userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return user;
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    User? user;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) => user = userCredential.user)
        .onError((error, stackTrace) => throw Exception(error.toString()));
    return user;
  }

  Future<void> signInWithEmail({
    required String email,
  }) async {
    await FirebaseAuth.instance.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://mspr-epsi-coffee.firebaseapp.com',
          handleCodeInApp: true,
        ));
  }

  //Sign in from a custom token (for example, a token from a custom authentication server)
  Future<User?> signInWithCustomToken({required String token}) async {
    return await FirebaseAuth.instance
        .signInWithCustomToken(token)
        .then((userCredential) => userCredential.user);
  }

  Future<void> signOut() async {
    try {
      await firebaseAuthInstance.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Allow users to sign in with several methods to a single one account.
  Future<void> linkWithCredentials(AuthCredential credential) async {
    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          throw Exception("Ce fournisseur est déjà associé au compte.");
        case "invalid-credential":
          throw Exception(
              "Les informations du compte fournisseur ne sont pas valides.");
        case "credential-already-in-use":
          throw Exception(
              "Ce compte de fournisseur est déjà utilisé par un autre compte.");
        case "email-already-in-use":
          throw Exception(
              "L'email de ce compte de fournisseur est déjà utilisé par un autre compte.");
        default:
          throw Exception(
              "Une erreur s'est produite lors de la liaison de votre compte");
      }
    }
  }

  //Reset password
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
