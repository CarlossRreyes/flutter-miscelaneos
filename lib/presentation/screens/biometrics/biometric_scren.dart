import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final canCheckBiometrics = ref.watch( canCheckBiometricsProvider );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
              
              },
              child: const Text('Autenticar')
            ),

            //TODO: Feedback process
            canCheckBiometrics.when(
              data: (data) => Text('Puede revisar biometricos: $data '), 
              error: (error, stackTrace) => Text('Error: $error'), 
              loading: () => const CircularProgressIndicator(),
            ),



            const SizedBox( height: 40 ),
            const Text('State biometric'),
            const Text('State xxxxx', style: TextStyle( fontSize: 20 ))
          ],
        ),
      ),
    );
  }
}