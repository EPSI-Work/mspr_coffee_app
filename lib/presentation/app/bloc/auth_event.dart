part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent([List props = const []]);

  @override
  List<Object> get props => [];
}

class ScanQrCode extends AuthEvent {
  ScanQrCode() : super([]);
}

class SignInWithEmail extends AuthEvent {
  final String email;
  SignInWithEmail({required this.email}) : super([email]);
}

class LogOut extends AuthEvent {}
