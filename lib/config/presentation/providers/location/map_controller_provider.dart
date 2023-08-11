import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool isReady;
  final bool isTracking;
  final List<Marker> markers;
  final GoogleMapController? controller;

  MapState(
      {this.isReady = false,
      this.isTracking = false,
      this.markers = const [],
      this.controller});

  Set<Marker> get markerSet => Set.from(markers);

  MapState copyWith({
    bool? isReady,
    bool? isTracking,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) =>
      MapState(
        isReady: isReady ?? this.isReady,
        isTracking: isTracking ?? this.isTracking,
        markers: markers ?? this.markers,
        controller: controller ?? this.controller,
      );
}

class MapNotifier extends StateNotifier<MapState> {
  StreamSubscription? userLocation$;
  (double, double)? lastKnownLocation;

  MapNotifier() : super(MapState()) {
    trackUser().listen((event) {
      lastKnownLocation = (event.$1, event.$2);
    });
  }

  Stream<(double, double)> trackUser() async* {
    await for (final position in Geolocator.getPositionStream()) {
      yield (position.latitude, position.longitude);
    }
  }

  void setMapController(GoogleMapController controller) {
    state = state.copyWith(controller: controller, isReady: true);
  }

  goToLocation(double latitude, double longitude) {
    final newPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15,
    );

    state.controller
        ?.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  toggleFollowUser() {
    state = state.copyWith(isTracking: !state.isTracking);

    if (state.isTracking) {
      findUser();
      userLocation$ = trackUser().listen((event) {
        goToLocation(event.$1, event.$2);
      });
    } else {
      userLocation$?.cancel();
    }
  }

//user the last stream to get the last location
  //user the last stream to get the last location
  findUser() {
    if (lastKnownLocation == null) return;
    final (latitude, longitude) = lastKnownLocation!;
    goToLocation(latitude, longitude);
    // trackUser().take(1).listen((event) {
    //   goToLocation(event.$1, event.$2);
    // });
  }

  void addMarkerCurrentPosition() {
    if (lastKnownLocation == null) return;

    final (latitude, longitude) = lastKnownLocation!;
    addMarker(latitude, longitude, 'My Custom Marker');
  }

  void addMarker(double latitude, double longitude, String name) {
    final newMarker = Marker(
      markerId: MarkerId('$state.markers.length ${DateTime.now()}'),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: name, snippet: 'Info window snippet'),
    );

    state = state.copyWith(markers: [...state.markers, newMarker]);
  }
}

final mapControllerProvider =
    StateNotifierProvider<MapNotifier, MapState>((ref) {
  return MapNotifier();
});
