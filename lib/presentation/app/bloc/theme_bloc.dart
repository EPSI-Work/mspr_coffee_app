import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ThemeDarkMode>(_onDarkMode);
    on<ThemeLightMode>(_onLightMode);
  }

  _onDarkMode(
    ThemeDarkMode event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(
      status: ThemeStatus.darkMode,
    ));
  }

  _onLightMode(
    ThemeLightMode event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(
      status: ThemeStatus.lightMode,
    ));
  }
}
