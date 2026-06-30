import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spot_memo/core/constants.dart';
import 'package:spot_memo/core/spacing.dart';
import 'package:spot_memo/l10n/generated/l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';

class LocationSelector extends ConsumerWidget {
  final GeoPoint? selectedLocation;
  final Function(double, double) onLocationChanged;

  const LocationSelector({
    super.key,
    required this.selectedLocation,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () => _pickLocation(context),
      borderRadius: BorderRadius.circular(4),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: AppLocalizations.of(context).location,
        ),
        child: selectedLocation != null
            ? AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: OSMViewer(
                          key: ValueKey(
                            '${selectedLocation!.latitude}-${selectedLocation!.longitude}',
                          ),
                          controller: SimpleMapController(
                            initPosition: selectedLocation!,
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
                          child: InkWell(onTap: () => _pickLocation(context)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: 56,
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: 12),
                    Expanded(child: Text(AppLocalizations.of(context).selectLocation)),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _pickLocation(BuildContext context) async {
    PermissionStatus status = await Permission.location.status;

    if (!status.isGranted) {
      if (status.isPermanentlyDenied) {
        await openAppSettings();
      }

      status = await Permission.locationWhenInUse.request();

      if (status.isPermanentlyDenied) {
        if (!context.mounted) return;

        toastification.show(
          context: context,
          title: Text(AppLocalizations.of(context).youDeniedLocation),
          type: ToastificationType.error,
          style: ToastificationStyle.flat,
          autoCloseDuration: DurationConstants.seconds5,
        );
        return;
      }
    }

    if (!context.mounted) return;

    final pickedLocation = await showSimplePickerLocation(
      context: context,
      title: AppLocalizations.of(context).selectLocation,
      textConfirmPicker: AppLocalizations.of(context).select,
      radius: 8,
      isDismissible: true,
      zoomOption: const ZoomOption(initZoom: 16),
      initCurrentUserPosition: status.isGranted
          ? const UserTrackingOption(enableTracking: true, unFollowUser: false)
          : null,
      initPosition: status.isGranted
          ? null
          : LocationConstants.amsterdamLocation,
    );

    if (!context.mounted || pickedLocation == null) return;

    onLocationChanged(pickedLocation.latitude, pickedLocation.longitude);
  }
}