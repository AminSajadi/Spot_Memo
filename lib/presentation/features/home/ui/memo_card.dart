import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:spot_memo/core/constants.dart';
import 'package:spot_memo/core/router/app_router.dart';
import 'package:spot_memo/core/spacing.dart';
import 'package:spot_memo/presentation/features/home/logic/memo_state.dart';

class MemoCard extends StatelessWidget {
  final MemoState memo;

  const MemoCard({super.key, required this.memo});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: Spacing.size8, horizontal: Spacing.size4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.size12)),
      child: InkWell(
        onTap: () => context.push(AppRoute.memoDetail.path, extra: memo),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: memo.mediaPath.isNotEmpty
                    ? Hero(
                  tag: "${TextConstants.imageHero}-${memo.id}",
                  child: Image.file(
                    width: 100,
                    height: 100,
                    File(memo.mediaPath),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 32)),
                  ),
                )
                    : const Center(child: Icon(Icons.image, size: 32)),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.size12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            memo.title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: Spacing.size4),
                          Text(
                            memo.desc,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: Spacing.size8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(memo.createdAt),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}