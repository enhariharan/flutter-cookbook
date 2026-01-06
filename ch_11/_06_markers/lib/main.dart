import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<LatLng> _userLocationFuture;
  late LatLng userPosition;
  List<Marker> markers = [];

  @override
  void initState() {
    _userLocationFuture = findUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: () => _findPlaces(), icon: const Icon(Icons.map))
        ],
      ),
      body: FutureBuilder(
          future: _userLocationFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            log('snapshot: $snapshot');
            log('snapshot.hasData: ${snapshot.hasData}');
            if (snapshot.hasData) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: snapshot.data!,
                  zoom: 12,
                ),
                markers: Set<Marker>.of(markers),
              );
            } else {
              log('Returning empty container');
              return Container();
            }
          },
      ),
    );
  }

  Future<LatLng> findUserLocation() async {
    log('findUserLocation()');
    Location location = Location();
    log('location: ${location.toString()}');
    bool active = await location.serviceEnabled();
    log('active: $active');
    PermissionStatus hasPermission = await location.hasPermission();
    log('hasPermission: $hasPermission');
    LocationData? userLocation;
    if (hasPermission == PermissionStatus.granted && active) {
      userLocation = await location.getLocation();
      userPosition = LatLng(userLocation.latitude!, userLocation.longitude!);
    } else {
      userLocation = null;
      userPosition = LatLng(51.5285582, -0.24167);
    }
    log('userLocation: ${userLocation?.toString()}');
    log('userPosition: $userPosition');
    return userPosition;
  }

  void _findPlaces() async {
    const key = 'AIzaSyAOYo9ZQKmEf963FUs3AKFdazz7EJZoVqk';
    const placesUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';
    final url = '${placesUrl}key=$key&type=restaurant&location=${userPosition.latitude},${userPosition.longitude}&radius=1000';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok) {
      final data = json.decode(response.body);
      _showMarkers(data);
    } else {
      throw Exception('Unable to retrieve places');
    }
  }

  void _showMarkers(data) {
    List places = data['results'];
    markers.clear();
    for(var place in places) {
      markers.add(
          Marker(
            markerId: MarkerId(place['reference']),
            position: LatLng(place['geometry']['location']['lat'], place['geometry']['location']['lng']),
          infoWindow: InfoWindow(
              title: place['name'],
              snippet: place['vicinity'])
          ),
      );
    }
    setState(() => markers = markers);
  }
}
