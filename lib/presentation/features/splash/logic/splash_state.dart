import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
sealed class SplashState with _$SplashState{
  const factory SplashState.loading() = SplashStateLoading;
  const factory SplashState.complete() = SplashStateComplete;
}
