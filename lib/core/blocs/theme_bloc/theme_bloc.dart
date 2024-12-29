import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/config/theme/light_theme_config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: lightTheme)) {
    on<SetThemeEvent>(_onThemeChangeEvent);
  }

  void _onThemeChangeEvent(SetThemeEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeData: event.themeData));
  }
}
