import 'package:communicatiehelper/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class MapsPage extends StatefulWidget {
  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  MyLocation myLocation = MyLocation();
  var currentLatLng;
  late GoogleMapController mapController;
  Location location = Location();
  var latitude;
  var longitude;
  late LocationData _locationData;

  get() async {
    location.requestPermission();
    _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
    setState(() {
      currentLatLng = LatLng(latitude, longitude);
      print(currentLatLng);
    });
  }

  @override
  initState() {
    super.initState();
    myLocation.determinePosition();
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kaarten'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Zoek locatie'),
          ),
          currentLatLng == null
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  height: 700.0,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    initialCameraPosition:
                        CameraPosition(target: currentLatLng, zoom: 15.0),
                  ),
                ),
        ],
      ),
    );
  }
}
