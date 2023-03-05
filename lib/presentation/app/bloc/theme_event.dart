part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent([List props = const []]);

  @override
  List<Object> get props => [];
}

class ThemeDarkMode extends ThemeEvent {}

class ThemeLightMode extends ThemeEvent {}
