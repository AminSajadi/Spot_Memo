import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spot_memo/data/dto/memo_dto.dart';

part 'memo_entity.freezed.dart';

typedef MemoMediaTypeEntity = MemoMediaTypeDto;

@freezed
abstract class MemoEntity with _$MemoEntity{
  const factory MemoEntity({
    required String id,
    required String title,
    required String desc,
    required DateTime createdAt,
    required String mediaPath,
    required MemoMediaTypeEntity mediaType,
    required double? lat,
    required double? lon,
  }) = _MemoEntity;
}
