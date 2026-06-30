import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spot_memo/data/repository/theme_repository_impl.dart';

part 'app_theme_provider.g.dart';

@Riverpod(keepAlive: true)
class AppThemeNotifier extends _$AppThemeNotifier {
  @override
  ThemeMode build() {
    final bool isDarkTheme = ref.read(themeRepositoryProvider).getTheme();
    return isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    if(state.isDark){
      state = ThemeMode.light;
      ref.read(themeRepositoryProvider).saveTheme(isDark: false);
    }else{
      state = ThemeMode.dark;
      ref.read(themeRepositoryProvider).saveTheme(isDark: true);
    }
  }
}
