import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spot_memo/data/dto/memo_dto.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'relational_database.g.dart';

@Riverpod(keepAlive: true)
RelationalDatabaseImpl relationalDatabase(Ref ref) {
  final db = RelationalDatabaseImpl();

  ref.onDispose(db.close);

  return db;
}

@DriftDatabase(tables: [MemoDto])
class RelationalDatabaseImpl extends _$RelationalDatabaseImpl implements RelationalDatabase {
  RelationalDatabaseImpl([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  Future<MemoDtoData> addMemo(MemoDtoCompanion memo) => into(memoDto).insertReturning(memo);

  @override
  Future<List<MemoDtoData>> getMemos() => (select(memoDto)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'database',
      native: const DriftNativeOptions(databaseDirectory: getApplicationSupportDirectory),
    );
  }
}

abstract class RelationalDatabase {
  Future<List<MemoDtoData>> getMemos();

  Future<MemoDtoData> addMemo(MemoDtoCompanion memo);
}
