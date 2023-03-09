import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mspr_coffee_app/data/services/auth/firebase_auth_repository.dart';
import 'package:mspr_coffee_app/domain/entities/entity.dart';
import 'package:mspr_coffee_app/domain/repositories/auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mspr_coffee_app/domain/repositories/user_repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static bool appleSignInAvailable = false;
  final AuthRepository authRepository = AuthRepository();
  AuthBloc() : super(const AuthState()) {
    on<SignInWithEmail>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      await authRepository.signInWithEmail(email: event.email).then((value) {
        emit(state.copyWith(
            status: AuthStatus.waitingScan, message: value.data['message']));
      }).onError((error, stackTrace) {
        if (error is FirebaseAuthException) {
          if (error.code == 'user-not-found') {
            emit(state.copyWith(
              status: AuthStatus.error,
              message: 'Aucun utilisateur trouvé pour cet email.',
            ));
          } else if (error.code == 'wrong-password') {
            emit(state.copyWith(
              status: AuthStatus.error,
              message: 'Mot de passe incorrect.',
            ));
          } else if (error.code == 'invalid-email') {
            emit(state.copyWith(
              status: AuthStatus.error,
              message: 'Email invalide.',
            ));
          } else if (error.code == 'user-disabled') {
            emit(state.copyWith(
              status: AuthStatus.error,
              message: 'Utilisateur désactivé.',
            ));
          } else if (error.code == 'too-many-requests') {
            emit(state.copyWith(
              status: AuthStatus.error,
              message: 'Trop de tentatives de connexion.',
            ));
          } else {
            emit(state.copyWith(
              status: AuthStatus.error,
              message: 'Erreur inconnue.',
            ));
          }
        } else {
          emit(state.copyWith(
            status: AuthStatus.error,
            message: 'Erreur inconnue.',
          ));
        }
      });
    });
    on<ScanQrCode>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      await authRepository
          .signInWithCustomToken(token: event.token)
          .then((user) {
        emit(state.copyWith(
            status: AuthStatus.authenticated,
            message: "Authentification réussie !"));
      }).onError((error, stackTrace) {
        if (error is FirebaseAuthException) {
          if (error.code == 'user-not-found') {
            emit(state.copyWith(
              status: AuthStatus.error,
              message: 'Aucun utilisateur trouvé pour cet email.',
            ));
          } else if (error.code == 'wrong-password') {
            emit(state.copyWith(
              status: AuthStatus.error,
              message: 'Mot de passe incorrect.',
            ));
          } else if (error.code == 'invalid-custom-token') {
            emit(state.copyWith(
              status: AuthStatus.error,
              message: 'Token invalide.',
            ));
          } else {
            emit(state.copyWith(
              status: AuthStatus.error,
              message: 'Une erreur est survenue.',
            ));
          }
        } else {
          debugPrint(error.toString());
          emit(state.copyWith(
            status: AuthStatus.error,
            message: 'Une erreur est survenue.',
          ));
        }
      });
    });
    on<LogOut>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      await authRepository.signOut().then((value) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      });
    });
  }
}
