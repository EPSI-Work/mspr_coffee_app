part of 'auth_bloc.dart';

enum AuthStatus {
  loading,
  unauthenticated,
  authenticated,
  error,
  waitingScan,
}

extension AuthStatusX on AuthStatus {
  bool get loading => this == AuthStatus.loading;
  bool get unauthenticated => this == AuthStatus.unauthenticated;
  bool get authenticated => this == AuthStatus.authenticated;
  bool get error => this == AuthStatus.error;
  bool get waitingScan => this == AuthStatus.waitingScan;
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.message = '',
  });

  final AuthStatus status;
  final String message;

  @override
  List<Object> get props => [status, message];

  AuthState copyWith({AuthStatus? status, String? message}) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
