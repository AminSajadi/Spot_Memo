import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spot_memo/data/source/relational_database.dart';
import 'package:spot_memo/domain/entity/memo_entity.dart';
import 'package:spot_memo/domain/entity/request_add_memo_entity.dart';
import 'package:spot_memo/domain/mappers/memo_mapper.dart';
import 'package:spot_memo/domain/repository/memo_repository.dart';

part 'memo_repository_impl.g.dart';

class MemoRepositoryImpl implements MemoRepository{
  RelationalDatabase database;
  MemoRepositoryImpl({required this.database});

  @override
  Future<List<MemoEntity>> getMemos() async {
    final List<MemoDtoData> memosDto = await database.getMemos();
    return memosDto.map((i) => MemoMapper.convertMemoDtoDataToMemoEntity(i)).toList();
  }

  @override
  Future<MemoEntity> saveMemo(RequestAddMemoEntity memoEntity) async {
    final MemoDtoData memoDtoData = await database.addMemo(MemoMapper.convertRequestAddMemoEntityToMemoDtoCompanion(memoEntity));
    return MemoMapper.convertMemoDtoDataToMemoEntity(memoDtoData);
  }
}

@riverpod
MemoRepositoryImpl memoRepository(Ref ref)=> MemoRepositoryImpl(database: ref.watch(relationalDatabaseProvider));
