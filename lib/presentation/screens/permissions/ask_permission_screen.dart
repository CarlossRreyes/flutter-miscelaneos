

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/permissions/permissions_provider.dart';


class AskPermissionScreen extends ConsumerWidget {
  const AskPermissionScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission required'),
      ),

      body: Center(
        child: FilledButton(
          onPressed: () {
            ref.read( permissionsProvider.notifier ).requestLocationAccess();
          }, 
          child: const Text('Location necesary')
        ),
      ),
    );
  }
}