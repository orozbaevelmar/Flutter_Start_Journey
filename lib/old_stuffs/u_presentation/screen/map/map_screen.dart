import 'dart:async';

import 'package:flutter/material.dart';
import 'package:start_journey/old_stuffs/model/app_lat_long.dart';
import 'package:start_journey/old_stuffs/services/location_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Текущее местоположение'),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            YandexMap(
              onMapTap: (Point point) {
                print(
                    "Latitude=${point.latitude} and Longtitude=${point.longitude}");
              },
              onMapCreated: (controller) {
                mapControllerCompleter.complete(controller);
              },
            ),
            /*  if (_showCircular)
              Center(
                child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CircularProgressIndicator(color: MColor.greenPrimary),
                ),
              ), */
            /* Positioned(
              bottom: 200,
              right: 16,
              child: Container(
                padding: EdgeInsets.all(8),
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF19A292)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: 0,
                      color: Color(0xFF0B211D).withOpacity(0.2),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/map/current-location.png',
                  fit: BoxFit.cover,
                ),
              ),
            ), */
          ],
        ),
      ),
    );
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = KyrgyzstanLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }

    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(
    AppLatLong appLatLong,
  ) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 12,
        ),
      ),
    );
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }

    await _fetchCurrentLocation();
  }
}
