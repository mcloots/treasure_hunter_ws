import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:treasure_hunter/models/location_model.dart';
import 'package:treasure_hunter/pages/ar_page.dart';

import '../apis/locations_api.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<StatefulWidget> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  List<Location> locationList = [];
  int count = 0;
  Position? _userPosition;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

// Request location permission and get user location
  Future<void> _requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return; // Permissions are denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return; // Permissions are denied forever
    }

    _getUserLocation();
  }

  // Get user location
  Future<void> _getUserLocation() async {

  }

  void _getLocations() {
    LocationsApi locApi = LocationsApi();
    locApi.fetchLocations(_userPosition).then((result) {
      setState(() {
        locationList = result;
        count = result.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _locationItems(),
    );
  }

  ListView _locationItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(locationList[position].name.substring(0, 1)),
            ),
            title: Text(locationList[position].name),
            subtitle: Text(
                "${locationList[position].distance.toStringAsFixed(2)} km (${locationList[position].texture})"),
            onTap: () {
              // Navigate to ARPage and pass the location
            },
          ),
        );
      },
    );
  }
}
