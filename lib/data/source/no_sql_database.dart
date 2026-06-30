import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_memo/core/constants.dart';

part 'no_sql_database.g.dart';

@Riverpod(keepAlive: true)
NoSqlDatabaseImpl noSqlDatabase(Ref ref)=> throw Exception();

abstract class NoSqlDatabase {
  bool getTheme();
  Future<void> saveTheme({required bool isDark});
}

class NoSqlDatabaseImpl implements NoSqlDatabase{
  SharedPreferences prefs;

  NoSqlDatabaseImpl({required this.prefs});

  @override
  bool getTheme() => prefs.getBool(DatabaseKeyConstants.isDarkTheme) ?? false;

  @override
  Future<void> saveTheme({required bool isDark}) => prefs.setBool(DatabaseKeyConstants.isDarkTheme, isDark);
}
