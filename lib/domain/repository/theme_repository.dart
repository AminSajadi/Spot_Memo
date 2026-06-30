abstract class ThemeRepository {
  bool getTheme();
  Future<void> saveTheme({required bool isDark});
}