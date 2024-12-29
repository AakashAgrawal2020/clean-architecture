part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent extends Equatable {}

class SetThemeEvent extends ThemeEvent {
  final ThemeData themeData;

  SetThemeEvent({required this.themeData});

  @override
  List<Object> get props => [themeData];
}
