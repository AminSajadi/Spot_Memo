import 'package:drift/drift.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:spot_memo/data/source/relational_database.dart';
import 'package:spot_memo/domain/entity/memo_entity.dart';
import 'package:spot_memo/domain/entity/request_add_memo_entity.dart';
import 'package:spot_memo/presentation/features/add_memo/logic/add_memo_state.dart';
import 'package:spot_memo/presentation/features/home/logic/memo_state.dart';
import 'package:uuid/uuid.dart';

class MemoMapper {
  static MemoEntity convertMemoDtoDataToMemoEntity(MemoDtoData memoDto) => MemoEntity(
    id: memoDto.id,
    title: memoDto.title,
    desc: memoDto.desc,
    createdAt: memoDto.createdAt,
    mediaPath: memoDto.mediaPath,
    mediaType: memoDto.mediaType,
    lat: memoDto.lat,
    lon: memoDto.lon,
  );

  static MemoDtoCompanion convertRequestAddMemoEntityToMemoDtoCompanion(RequestAddMemoEntity memoEntity) => MemoDtoCompanion(
    id: Value(Uuid().v4()),
    title: Value(memoEntity.title),
    desc: Value(memoEntity.desc),
    createdAt: Value(DateTime.now()),
    mediaPath: Value(memoEntity.mediaPath),
    mediaType: Value(memoEntity.mediaType),
    lat: Value(memoEntity.lat),
    lon: Value(memoEntity.lon),
  );

  static MemoState convertMemoEntityToMemoState(MemoEntity memoEntity) => MemoState(
      id: memoEntity.id,
      title: memoEntity.title,
      desc: memoEntity.desc,
      createdAt: memoEntity.createdAt,
      mediaPath: memoEntity.mediaPath,
      mediaType: memoEntity.mediaType,
      lat: memoEntity.lat,
      lon: memoEntity.lon,
    );

  static GeoPoint? convertAddMemoLocationStateToGeoPoint(AddMemoLocationState? locationState){
    if(locationState == null) return null;
    return GeoPoint(latitude: locationState.lat, longitude: locationState.lon);
  }
}
