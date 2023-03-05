import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mspr_coffee_app/common/error/app_exception.dart';
import 'package:mspr_coffee_app/data/services/auth/firebase_auth_repository.dart';
import 'package:mspr_coffee_app/domain/entity/entity.dart';
import 'package:mspr_coffee_app/domain/repository/auth_repository/auth_repository.dart';
import 'package:mspr_coffee_app/presentation/app/bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AuthBloc authBloc;
  final FirebaseAuthRepository firebaseAuthRepository =
      FirebaseAuthRepository();
  bool startListeningAuthChange = false;
  AppBloc({required this.authBloc}) : super(const AppState()) {
    authBloc.stream.listen((authState) {
      switch (authState.runtimeType) {
        case Authenticated:
          _firebaseCheckAuthState();
          startListeningAuthChange = true;
          break;
        default:
      }
    });

    FirebaseAuthRepository.firebaseAuthInstance
        .authStateChanges()
        .listen((firebase.User? firebaseUser) async {
      ///This Stream is not used until the authentication process isn't completed.
      log("startListeningAuthChange = $startListeningAuthChange");
      if (startListeningAuthChange) {
        if (firebaseUser != null) {
          print('User is signed in on mobile!');
          try {
            await AuthRepository()
                .whoAmI(firebaseUser: firebaseUser)
                .then((user) {
              log(user.toString());
              emit(state.copyWith(
                status: AppStatus.login,
                message: '',
                authUser: user.copyWith(firebaseUser: firebaseUser),
              ));
            }).onError((AppException error, stackTrace) async {
              if (error.statusCode == 401) {
                FirebaseAuthRepository.firebaseAuthInstance.signOut();
              }
            });
          } catch (e) {
            emit(state.copyWith(
              status: AppStatus.logout,
              message: '',
              authUser: null,
            ));
          }
        } else {
          print('User is currently signed out!');
          emit(state.copyWith(
            status: AppStatus.logout,
            message: '',
            authUser: null,
          ));
        }
      }
    });

    on<UserLogInState>((event, emit) async {
      _firebaseCheckAuthState();
    });
  }

  _firebaseCheckAuthState() async {
    try {
      if (FirebaseAuthRepository.firebaseAuthInstance.currentUser != null) {
        print('On start the user is signed in');
        //await FirebaseAuthRepository.firebaseAuthInstance.signOut();
        await AuthRepository()
            .whoAmI(
                firebaseUser:
                    FirebaseAuthRepository.firebaseAuthInstance.currentUser!)
            .then((user) {
          startListeningAuthChange = true;
          log(user.toString());
          emit(state.copyWith(
            status: AppStatus.login,
            message: '',
            authUser: user.copyWith(
                firebaseUser:
                    FirebaseAuthRepository.firebaseAuthInstance.currentUser!),
          ));
        }).onError((AppException error, stackTrace) async {
          if (error.statusCode == 401) {
            FirebaseAuthRepository.firebaseAuthInstance.signOut();
            emit(state.copyWith(
              status: AppStatus.logout,
              message: '',
              authUser: null,
            ));
          }
        });
      } else {
        print('On start the user is not signed in');
        emit(state.copyWith(
          status: AppStatus.logout,
          message: '',
          authUser: null,
        ));
      }
    } catch (e) {
      print('On start the user is not signed in');
      emit(state.copyWith(
        status: AppStatus.logout,
        message: '',
        authUser: null,
      ));
    }
  }
}
