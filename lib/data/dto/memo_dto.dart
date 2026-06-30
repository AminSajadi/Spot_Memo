import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

enum MemoMediaTypeDto{
  local,
  fromUrl;
}

class MemoDto extends Table {
  TextColumn get id => text().clientDefault(() => Uuid().v4()).named('id')();
  TextColumn get title => text().named('title')();
  TextColumn get desc => text().named('desc')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  TextColumn get mediaPath => text().named('media_path')();
  TextColumn get mediaType => textEnum<MemoMediaTypeDto>().named('media_type')();
  RealColumn get lat => real().nullable().named('lat')();
  RealColumn get lon => real().nullable().named('lon')();

  @override
  Set<Column> get primaryKey => {id};
}