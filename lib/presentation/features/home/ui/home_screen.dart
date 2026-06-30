import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spot_memo/core/router/app_router.dart';
import 'package:spot_memo/core/spacing.dart';
import 'package:spot_memo/core/text_styles.dart';
import 'package:spot_memo/l10n/generated/l10n/app_localizations.dart';
import 'package:spot_memo/presentation/features/app_theme/logic/app_theme_provider.dart';
import 'package:spot_memo/presentation/features/home/logic/memo_list_provider.dart';
import 'package:spot_memo/presentation/features/home/logic/memo_state.dart';
import 'package:spot_memo/presentation/features/home/ui/memo_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoute.addMemo.path),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(Spacing.size16, Spacing.size16, Spacing.size16, Spacing.size8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context).appName, style: TextStyles.headlineMedium),
                      Switch(
                        value: ref.watch(appThemeProvider).isDark,
                        onChanged: (value) => ref.read(appThemeProvider.notifier).switchTheme(),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Spacing.size8),
                  height: 1,
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await ref.read(memoListProvider.notifier).fetchMemos(),
                child: ref.watch(memoListProvider).map(
                  loading: (_) => _MemoListLoading(),
                  data: (list) => _MemoListData(memos: list.memos),
                  empty: (_) => _MemoListEmpty(),
                  error: (_) => _MemoListError(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoListLoading extends StatelessWidget {
  const _MemoListLoading();

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class _MemoListError extends StatelessWidget {
  const _MemoListError();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error),
          Text(AppLocalizations.of(context).fetchMemosFailed, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _MemoListEmpty extends StatelessWidget {
  const _MemoListEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty),
          Text(AppLocalizations.of(context).fetchMemosEmptyList, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _MemoListData extends StatelessWidget {
  final List<MemoState> memos;

  const _MemoListData({required this.memos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(Spacing.size16),
      itemCount: memos.length,
      itemBuilder: (context, index) {
        final MemoState memo = memos[index];
        return MemoCard(memo: memo);
      },
    );
  }
}
