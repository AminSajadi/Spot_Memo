import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spot_memo/presentation/features/add_memo/ui/add_memo_screen.dart';
import 'package:spot_memo/presentation/features/home/logic/memo_state.dart';
import 'package:spot_memo/presentation/features/home/ui/home_screen.dart';
import 'package:spot_memo/presentation/features/memo_detail/ui/memo_detail_screen.dart';
import 'package:spot_memo/presentation/features/splash/ui/splash_screen.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(ref) {
  final router = GoRouter(
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        pageBuilder: (context, state) => const NoTransitionPage(child: SplashScreen()),
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fade = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
            return FadeTransition(opacity: fade, child: child);
          },
        ),
      ),
      GoRoute(
        path: AppRoute.addMemo.path,
        name: AppRoute.addMemo.name,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const AddMemoScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fade = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
            return FadeTransition(opacity: fade, child: child);
          },
        ),
      ),
      GoRoute(
        path: AppRoute.memoDetail.path,
        name: AppRoute.memoDetail.name,
        pageBuilder: (context, state) {
          final MemoState memo = state.extra as MemoState;
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: MemoDetailScreen(memo: memo),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final fade = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
              return FadeTransition(opacity: fade, child: child);
            },
          );
        },
      ),
    ],
  );

  ref.onDispose(router.dispose);

  return router;
}

enum AppRoute {
  splash("/splash"),
  home("/home"),
  addMemo("/addMemo"),
  memoDetail("/memoDetail");

  const AppRoute(this.path);

  final String path;
}
