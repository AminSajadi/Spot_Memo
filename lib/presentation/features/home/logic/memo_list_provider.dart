import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spot_memo/data/repository/memo_repository_impl.dart';
import 'package:spot_memo/domain/entity/memo_entity.dart';
import 'package:spot_memo/domain/mappers/memo_mapper.dart';
import 'package:spot_memo/presentation/features/home/logic/memo_state.dart';

part 'memo_list_provider.g.dart';

@Riverpod(keepAlive: true)
class MemoListNotifier extends _$MemoListNotifier {
  @override
  MemoListState build() {
    fetchMemos();
    return MemoListState.loading();
  }

  Future<bool> fetchMemos() async {
    final List<MemoEntity> memoEntityList = await ref.read(memoRepositoryProvider).getMemos();
    final List<MemoState> memoStates = memoEntityList.map((i) => MemoMapper.convertMemoEntityToMemoState(i)).toList();
    if(memoStates.isEmpty){
      state = MemoListState.empty();
    }else{
      state = MemoListState.data(memos: memoStates);
    }
    return true;
  }

  addMemoToList(MemoState memoState) {
    state = state.maybeMap(
      data: (list) => list.copyWith(memos: [memoState, ...list.memos]),
      orElse: () => MemoListState.data(memos: [memoState]),
    );
  }
}
