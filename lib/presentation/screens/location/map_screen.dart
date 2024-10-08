import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/location/user_location_provider.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final currentPositionAsync = ref.watch( userLocationProvider );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: currentPositionAsync.when(
        data: (data) => _MapView(initialLat: data.$1, initialLng: data.$2), 
        error: (error, stackTrace) => Text('Error: $error'), 
        loading: () => const Center( child: CircularProgressIndicator() ),
      ),
    );
  }
}

class _MapView extends StatefulWidget {
  final double initialLat;
  final double initialLng;
  const _MapView({ required this.initialLat, required this.initialLng});

  @override
  State<_MapView> createState() => __MapViewState();
}

class __MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng( widget.initialLat, widget.initialLng ),
        zoom: 12
      ),
      mapType: MapType.hybrid,
      myLocationEnabled: true,
      // myLocationButtonEnabled: true,
      // zoomControlsEnabled: true,
      // zoomGesturesEnabled: true,
      onMapCreated: (controller) {
        
      },

    );
  }
}
