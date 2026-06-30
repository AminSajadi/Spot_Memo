import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spot_memo/core/router/app_router.dart';
import 'package:spot_memo/data/repository/memo_repository_impl.dart';
import 'package:spot_memo/domain/entity/memo_entity.dart';
import 'package:spot_memo/domain/entity/request_add_memo_entity.dart';
import 'package:spot_memo/domain/mappers/memo_mapper.dart';
import 'package:spot_memo/l10n/generated/l10n/app_localizations.dart';
import 'package:spot_memo/presentation/features/add_memo/logic/add_memo_state.dart';
import 'package:spot_memo/presentation/features/home/logic/memo_list_provider.dart';
import 'package:spot_memo/presentation/features/home/logic/memo_state.dart';

part 'add_memo_provider.g.dart';

@riverpod
class AddMemoNotifier extends _$AddMemoNotifier {
  @override
  AddMemoState build() => AddMemoState(status: AddMemoStatusState.idle());

  changeImagePath(String newImagePath) => state = state.copyWith(imagePath: newImagePath);

  changeTitle(String newTitle) => state = state.copyWith(title: newTitle);

  changeDesc(String newDesc) => state = state.copyWith(desc: newDesc);

  changeLocation(double lat, double lon) => state = state.copyWith(
    location: AddMemoLocationState(lat: lat, lon: lon),
  );

  saveMemo(AppLocalizations l10n) async {
    if (state.title.isEmpty) {
      state = state.copyWith(status: AddMemoStatusState.error(error: l10n.memoMissingItem(l10n.memoMissingItemTitle)));
      return;
    } else if (state.desc.isEmpty) {
      state = state.copyWith(status: AddMemoStatusState.error(error: l10n.memoMissingItem(l10n.memoMissingItemDesc)));
      return;
    } else if (state.imagePath == null || state.imagePath!.isEmpty) {
      state = state.copyWith(status: AddMemoStatusState.error(error: l10n.memoMissingItem(l10n.memoMissingItemImage)));
      return;
    }

    state = state.copyWith(status: AddMemoStatusState.loading());
    final MemoEntity memoEntity = await ref
        .read(memoRepositoryProvider)
        .saveMemo(
          RequestAddMemoEntity(
            title: state.title,
            desc: state.desc,
            mediaPath: state.imagePath!,
            mediaType: MemoMediaTypeEntity.local,
            lat: state.location?.lat,
            lon: state.location?.lon,
          ),
        );
    final MemoState memoState = MemoMapper.convertMemoEntityToMemoState(memoEntity);
    ref.read(memoListProvider.notifier).addMemoToList(memoState);
    ref.read(appRouterProvider).pop();
    ref.invalidateSelf();
  }
}
