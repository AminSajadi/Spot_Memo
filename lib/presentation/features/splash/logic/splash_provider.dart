import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spot_memo/core/router/app_router.dart';
import 'package:spot_memo/presentation/features/splash/logic/splash_state.dart';

part 'splash_provider.g.dart';

@riverpod
class SplashNotifier extends _$SplashNotifier{
  @override
  SplashState build() {
    _initialize();
    return SplashState.loading();
  }

  _initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    state = SplashState.complete();

    ref.read(appRouterProvider).go(AppRoute.home.path);
  }
}