import 'package:spot_memo/domain/entity/memo_entity.dart';
import 'package:spot_memo/domain/entity/request_add_memo_entity.dart';

abstract class MemoRepository {
  Future<List<MemoEntity>> getMemos();
  Future<MemoEntity> saveMemo(RequestAddMemoEntity memoEntity);
}