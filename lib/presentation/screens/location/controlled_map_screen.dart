import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../providers/providers.dart';




class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    // final watchUserLocation = ref.watch( watchLocationProvider );
    final watchUserLocation = ref.watch( userLocationProvider );
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Controlled Map Screen'),
      // ),
      body: watchUserLocation.when(
        data: (data) => MapAndControls(latitude: data.$1, longitude: data.$2), 
        error: (error, stackTrace) => Text('Error: $error'), 
        loading: () => const Center( child: CircularProgressIndicator() ),
      ),
    );
  }
}


class MapAndControls extends ConsumerWidget {
  final double latitude;
  final double longitude;
  const MapAndControls({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context, ref) {

    final mapControllerState = ref.watch( mapControllerProvider );

    return Stack(
      children: [
        _MapView(
          initialLat: latitude, 
          initialLng: longitude
        ),
        Positioned(
          top: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              context.pop();
            }, 
            icon: const Icon(Icons.arrow_back)
          )
        ),
        //TODO: go to user position 
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref.read( mapControllerProvider.notifier )
                .goToLocation(latitude, longitude);
            }, 
            icon: const Icon(Icons.location_searching)
          )
        ),
        //TODO: seguir usuario 
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref.read( mapControllerProvider.notifier )
                .toggleFollowUser();           
            }, 
            icon: Icon(
              mapControllerState.followUser ? Icons.directions_run_outlined
                : Icons.accessibility_new_outlined
            ) 
          )
        ),
        //TODO: create marcker 
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              // context.pop();
            }, 
            icon: const Icon(Icons.pin_drop)
          )
        ),
      ],
    );  
  }
}



class _MapView extends ConsumerStatefulWidget {
  final double initialLat;
  final double initialLng;
  const _MapView({ required this.initialLat, required this.initialLng});

  @override
  __MapViewState createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
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
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      // zoomGesturesEnabled: true,
      onMapCreated: (controller) {
        ref.read( mapControllerProvider.notifier )
          .setMapController(controller);
      },

    );
  }
}
