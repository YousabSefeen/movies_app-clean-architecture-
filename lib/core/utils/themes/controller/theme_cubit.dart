import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils/themes/controller/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  static ThemeCubit object(context) => BlocProvider.of(context);
  ThemeMode theme = ThemeMode.system;

  String textTheme = 'system';

  void changeTheme() async {
    if (theme == ThemeMode.light) {
      theme = ThemeMode.dark;
      textTheme = 'dark';
    } else {
      theme = ThemeMode.light;
      textTheme = 'light';
    }
    emit(ChangeThemeState());
    final pref = await SharedPreferences.getInstance();
    pref.setString('textTheme', textTheme);
  }

  _getTheme(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      textTheme = 'system';
    } else if (themeMode == ThemeMode.light) {
      textTheme = 'light';
    } else if (themeMode == ThemeMode.dark) {
      textTheme = 'dark';
    }
  }

  getThemePref() async {
    final pref = await SharedPreferences.getInstance();

    textTheme = pref.getString('textTheme') ?? 'system';

    if (textTheme == 'system') {
      theme = ThemeMode.system;
    } else if (textTheme == 'light') {
      theme = ThemeMode.light;
    } else if (textTheme == 'dark') {
      theme = ThemeMode.dark;
    }

    emit(GetThemeState());
  }
}
