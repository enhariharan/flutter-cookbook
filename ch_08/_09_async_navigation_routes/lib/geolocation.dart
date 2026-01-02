import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late Future<Position> position;
  String myPosition = '';

  @override
  void initState() {
    super.initState();
    position = getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Location')),
      body: Center(
        child: FutureBuilder(
          future: position,
          builder: (context, AsyncSnapshot<Position> asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              log('ConnectionState.waiting');
              return const CircularProgressIndicator();
            } else if (asyncSnapshot.connectionState == ConnectionState.done) {
              if (asyncSnapshot.hasError) {
                return Text('There was an error while fetching current position: ${asyncSnapshot.error.toString()}');
              }
              log('ConnectionState.done');
              return Text(asyncSnapshot.data.toString());
            } else {
              log('None');
              return const Text('');
            }
          },
        ),
      ),
    );
  }

  Future<Position> getPosition() async {
    await Future.delayed(const Duration(seconds: 30));
    if (Platform.isLinux) {
      log('Geolocator is not supported on Linux, returning 0 position');
      return Position(
        latitude: 0.0,
        longitude: 0.0,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      );
    }
    await Geolocator.requestPermission();
    await Geolocator.isLocationServiceEnabled();
    Position? position = await Geolocator.getCurrentPosition();
    return position;
  }
}
