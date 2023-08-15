import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscellanous/config/presentation/providers/providers.dart';
// import 'package:miscellanous/config/presentation/providers/app_state_provider.dart';

class PermissionsScreen extends ConsumerWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions')),
      body: const _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissions = ref.watch(permissionsProvider);
    final showAds = ref.watch(showAdsProvider);

    return ListView(
      children: [
        CheckboxListTile(
          value: permissions.cameraGranted,
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestCameraAccess();
          },
          title: const Text('Camera'),
          subtitle: Text('${permissions.camera}'),
        ),
        CheckboxListTile(
          value: permissions.photoLibraryGranted,
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestGalleryAccess();
          },
          title: const Text('Gallery'),
          subtitle: Text('${permissions.photoLibrary}'),
        ),
        CheckboxListTile(
          value: permissions.locationGranted,
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestLocationAccess();
          },
          title: const Text('Location'),
          subtitle: Text('${permissions.location}'),
        ),
        CheckboxListTile(
          value: permissions.sensorsGranted,
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestSensorsAccess();
          },
          title: const Text('Sensors'),
          subtitle: Text('${permissions.sensors}'),
        ),
        CheckboxListTile(
          value: showAds,
          onChanged: (_) {
            ref.read(showAdsProvider.notifier).toggleAds();
          },
          title: const Text('Show Ads'),
          subtitle: const Text('This will show ads in the app'),
        ),
      ],
    );
  }
}
