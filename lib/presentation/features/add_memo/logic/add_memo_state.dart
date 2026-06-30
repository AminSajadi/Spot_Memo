import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_memo_state.freezed.dart';

@freezed
abstract class AddMemoState with _$AddMemoState {
  const factory AddMemoState({
    @Default("") String title,
    @Default("") String desc,
    @Default(null) String? imagePath,
    @Default(null) AddMemoLocationState? location,
    required AddMemoStatusState status,
  }) = _AddMemoState;
}

@freezed
abstract class AddMemoLocationState with _$AddMemoLocationState {
  const factory AddMemoLocationState({required double lat, required double lon}) = _AddMemoLocationState;
}

@freezed
sealed class AddMemoStatusState with _$AddMemoStatusState {
  const factory AddMemoStatusState.idle() = _AddMemoStatusStateIdle;

  const factory AddMemoStatusState.loading() = _AddMemoStatusStateLoading;

  const factory AddMemoStatusState.error({required String error}) = _AddMemoStatusStateError;
}
