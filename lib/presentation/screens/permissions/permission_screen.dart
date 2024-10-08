import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';


class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission') ,
      ),

      body: const _PermissionView() ,
    );
  }
}

class _PermissionView extends ConsumerWidget {
  const _PermissionView();

  @override
  Widget build(BuildContext context, ref) {

    final permissions = ref.watch( permissionsProvider );
    
    return ListView(
      children: [
        CheckboxListTile(
          value: permissions.cameraGranted, 
          title: const Text('Camera'),
          subtitle: Text('${ permissions.camera }'),
          onChanged: ( _ ) {
            ref.read( permissionsProvider.notifier ).requestCameraAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.photoLibraryGranted, 
          title: const Text('Gallery and photos'),
          // subtitle: Text('State'),
          subtitle: Text('${ permissions.photoLibrary }'),
          onChanged: ( _ ) {
            ref.read( permissionsProvider.notifier ).requestPhotoLibraryAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.locationGranted, 
          title: const Text('Location'),
          // subtitle: Text('State'),
          subtitle: Text('${ permissions.location }'),
          onChanged: ( _ ) {
            ref.read( permissionsProvider.notifier ).requestLocationAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.sensorsGranted, 
          title: const Text('Sensors'),
          // subtitle: Text('State'),
          subtitle: Text('${ permissions.sensors }'),
          onChanged: ( _ ) {
            ref.read( permissionsProvider.notifier ).requestSensorsAccess();
          },
        ),


      ],
    );
  }
}