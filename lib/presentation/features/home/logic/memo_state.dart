import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spot_memo/domain/entity/memo_entity.dart';

part 'memo_state.freezed.dart';

typedef MemoMediaTypeState = MemoMediaTypeEntity;

@freezed
sealed class MemoListState with _$MemoListState {
  const factory MemoListState.loading() = _MemoListStateLoading;

  const factory MemoListState.data({required List<MemoState> memos}) = _MemoListStateData;

  const factory MemoListState.empty() = _MemoListStateEmpty;

  const factory MemoListState.error() = _MemoListStateError;
}

@freezed
abstract class MemoState with _$MemoState {
  const factory MemoState({
    required String id,
    required String title,
    required String desc,
    required DateTime createdAt,
    required String mediaPath,
    required MemoMediaTypeEntity mediaType,
    required double? lat,
    required double? lon,
  }) = _MemoState;
}
