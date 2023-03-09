import 'dart:developer';

import 'package:mspr_coffee_app/domain/repositories/user_repository/user_repository.dart';
import 'package:mspr_coffee_app/data/services/auth/firebase_auth_repository.dart';
import 'package:mspr_coffee_app/domain/entities/entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:mspr_coffee_app/data/repositories/http/auth_repository/auth_repository.dart'
    as data_auth_repository;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mspr_coffee_app/domain/responses/sucess_response.dart';

class AuthRepository {
  static FirebaseAuthRepository firebaseAuthRepository =
      FirebaseAuthRepository();
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User> whoAmI({required firebase.User firebaseUser}) async {
    return UserRepository().getOne(docId: firebaseUser.uid).then((User user) {
      return user.copyWith(
        firebaseUser: firebaseUser,
      );
    });
  }

  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await firebaseAuthRepository
          .signIn(email: email, password: password)
          .then((signedUser) async {
        return await whoAmI(firebaseUser: signedUser!).then((user) => user);
        /*if (signedUser != null) {
          return await whoAmI(firebaseUser: signedUser).then((user) => user);
        } else {
          throw Exception("Authentification échouée.");
        }*/
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<SuccessResponse> signInWithEmail({required String email}) async {
    try {
      return SuccessResponse(200, {
        "message": "Un email de connexion vous a été envoyé.",
      });
      return await data_auth_repository.AuthRepository()
          .signInWithEmail(email: email)
          .then(
              (value) => SuccessResponse(value.statusCode, value.responseJson));
    } catch (e) {
      rethrow;
    }
  }

  //Sign in from a custom token (for example, a token from a custom authentication server)
  Future<User> signInWithCustomToken({required String token}) async {
    try {
      return await firebaseAuthRepository
          .signInWithCustomToken(token: token)
          .then((signedUser) async {
        if (signedUser != null) {
          return await whoAmI(firebaseUser: signedUser).then((user) => user);
        } else {
          throw Exception("Authentification échouée.");
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<firebase.User> register({
    required String email,
    required String password,
    required String firstname,
  }) async {
    try {
      return await firebaseAuthRepository
          .signUp(email: email, password: password)
          .then((signedUser) async {
        if (signedUser != null) {
          await UserRepository().create(
            User(
              uid: signedUser.uid,
              email: email,
              firstname: firstname,
              firebaseUser: signedUser,
            ),
          );
          return signedUser;
        } else {
          throw Exception("Authentification échouée.");
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await firebaseAuthRepository.signOut();
  }
}
