import 'package:clean_architecture/core/config/theme/dark_theme_config.dart';
import 'package:clean_architecture/core/config/theme/light_theme_config.dart';
import 'package:clean_architecture/core/utils/storage/local_storage/secured_local_storage.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  late ThemeData theme;

  static final ThemeManager _singleton = ThemeManager._internal();

  factory ThemeManager() {
    return _singleton;
  }

  ThemeManager._internal() {
    theme = lightTheme;
  }

  Future<void> setTheme({required ThemeData themeData}) async {
    if (themeData == lightTheme) {
      await SecuredLocalStorage().setValue('themeName', 'lightTheme');
    } else {
      await SecuredLocalStorage().setValue('themeName', 'darkTheme');
    }
  }

  Future<void> getTheme() async {
    try {
      String? themeName = await SecuredLocalStorage().getValue('themeName');
      if (themeName != null && themeName.isNotEmpty) {
        ThemeManager().theme =
            themeName == 'lightTheme' ? lightTheme : darkTheme;
      } else {
        ThemeManager().theme = lightTheme;
      }
    } catch (e) {
      debugPrint('getSessionToken() => $e');
    }
  }
}
