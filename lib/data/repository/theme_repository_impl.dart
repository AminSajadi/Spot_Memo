import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spot_memo/data/source/no_sql_database.dart';
import 'package:spot_memo/domain/repository/theme_repository.dart';

part 'theme_repository_impl.g.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final NoSqlDatabase database;

  ThemeRepositoryImpl({required this.database});

  @override
  bool getTheme() => database.getTheme();

  @override
  Future<void> saveTheme({required bool isDark}) async => await database.saveTheme(isDark: isDark);
}

@riverpod
ThemeRepositoryImpl themeRepository(Ref ref)=> ThemeRepositoryImpl(database: ref.watch(noSqlDatabaseProvider));
