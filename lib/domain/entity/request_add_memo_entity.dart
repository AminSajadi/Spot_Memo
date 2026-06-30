import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spot_memo/domain/entity/memo_entity.dart';

part 'request_add_memo_entity.freezed.dart';

@freezed
abstract class RequestAddMemoEntity with _$RequestAddMemoEntity {
  const factory RequestAddMemoEntity({
    required String title,
    required String desc,
    required String mediaPath,
    required MemoMediaTypeEntity mediaType,
    required double? lat,
    required double? lon,
  }) = _RequestAddMemoEntity;
}
