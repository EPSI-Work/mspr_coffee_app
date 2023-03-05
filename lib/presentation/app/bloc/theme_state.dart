part of 'theme_bloc.dart';

enum ThemeStatus {
  initial,
  darkMode,
  lightMode,
}

extension ThemeStatusX on ThemeStatus {
  bool get initial => this == ThemeStatus.initial;
  bool get darkMode => this == ThemeStatus.darkMode;
}

class ThemeState extends Equatable {
  const ThemeState({
    this.status = ThemeStatus.initial,
  });

  final ThemeStatus status;

  @override
  List<Object> get props => [status];

  ThemeState copyWith({
    ThemeStatus? status,
  }) {
    return ThemeState(
      status: status ?? this.status,
    );
  }
}
