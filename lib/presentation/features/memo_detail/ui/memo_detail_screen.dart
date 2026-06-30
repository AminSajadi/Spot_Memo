import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:spot_memo/core/constants.dart';
import 'package:spot_memo/core/spacing.dart';
import 'package:spot_memo/core/text_styles.dart';
import 'package:spot_memo/presentation/features/home/logic/memo_state.dart';
import 'package:url_launcher/url_launcher.dart';

class MemoDetailScreen extends StatelessWidget {
  final MemoState memo;

  const MemoDetailScreen({super.key, required this.memo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Spacing.size8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_outlined),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(Spacing.size16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Hero(
                          tag: "${TextConstants.imageHero}-${memo.id}",
                          child: Image.file(
                            File(memo.mediaPath),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Center(
                                child: Icon(Icons.broken_image, size: 48),
                              ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: Spacing.size24),
                    Text(memo.title, style: TextStyles.headlineMedium),
                    const SizedBox(height: Spacing.size8),
                    Text(
                      DateFormat('yyyy-MM-dd').format(memo.createdAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: Spacing.size24),
                    Text(memo.desc, style: TextStyles.bodyLarge),
                    const SizedBox(height: Spacing.size24),
                    (memo.lat != null && memo.lon != null) ? AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: OSMViewer(
                                key: ValueKey(
                                  '${memo.lat}-${memo.lon}',
                                ),
                                controller: SimpleMapController(
                                  initPosition: GeoPoint(latitude: memo.lat!, longitude: memo.lon!),
                                  markerHome: const MarkerIcon(
                                    icon: Icon(
                                      Icons.location_pin,
                                      color: Colors.red,
                                      size: Spacing.size48,
                                    ),
                                  ),
                                ),
                                zoomOption: const ZoomOption(initZoom: 16),
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(onTap: () => _openMap(memo.lat!, memo.lon!)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ): SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openMap(double latitude, double longitude) async {
    final Uri googleMapUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
  }
}
