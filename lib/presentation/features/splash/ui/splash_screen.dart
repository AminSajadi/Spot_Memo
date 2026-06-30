import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_memo/core/spacing.dart';
import 'package:spot_memo/l10n/generated/l10n/app_localizations.dart';
import 'package:spot_memo/presentation/features/splash/logic/splash_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(splashProvider);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primaryContainer,
              colorScheme.surface,
              colorScheme.secondaryContainer,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(Spacing.size24),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.24),
                      blurRadius: 32,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.location_on_rounded,
                  color: colorScheme.onPrimary,
                  size: 46,
                ),
              ),
              const SizedBox(height: Spacing.size28),
              Text(
                AppLocalizations.of(context).appName,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: Spacing.size12),
              SizedBox(
                width: 112,
                child: LinearProgressIndicator(
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
