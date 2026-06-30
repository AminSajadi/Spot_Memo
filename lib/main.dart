import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_memo/core/constants.dart';
import 'package:spot_memo/core/theme.dart';
import 'package:spot_memo/data/source/no_sql_database.dart';
import 'package:spot_memo/l10n/generated/l10n/app_localizations.dart';
import 'package:spot_memo/presentation/features/app_theme/logic/app_theme_provider.dart';
import 'package:spot_memo/core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [noSqlDatabaseProvider.overrideWithValue(NoSqlDatabaseImpl(prefs: sharedPrefs))],
      child: SpotMemoApp(),
    ),
  );
}

class SpotMemoApp extends ConsumerWidget {
  const SpotMemoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialTheme = MaterialTheme(ThemeData(fontFamily: TextConstants.nationalParkFont).textTheme);
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale("en"),
      title: TextConstants.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(appRouterProvider),
      themeMode: ref.watch(appThemeProvider),
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
    );
  }
}
