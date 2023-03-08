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
          }
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
