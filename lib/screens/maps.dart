import 'dart:async';
import 'package:communicatiehelper/screens/maps_fragment/application_block.dart';
import 'package:communicatiehelper/screens/maps_fragment/places_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsPage extends StatefulWidget {
  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Completer<GoogleMapController> _mapController = Completer();
  TextEditingController _searchController = TextEditingController();

  List<LatLng> polygonLatLngs = <LatLng>[];

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final applicationBlock = Provider.of<ApplicationBlock>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kaarten'),
        centerTitle: true,
      ),
      body: (applicationBlock.currentLocation == null)
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                        child: TextField(
                          controller: _searchController,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Zoek een plaats',
                          ),
                          onChanged: (value) {
                            print(value);
                          },
                          onSubmitted: (value) async {
                            var place = await PlaceService().getPlace(value);
                            _goToPlace(place);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: {
                      Marker(
                          markerId: const MarkerId('Thuis'),
                          infoWindow: const InfoWindow(title: 'Thuis'),
                          icon: BitmapDescriptor.defaultMarker,
                          position: LatLng(
                              applicationBlock.currentLocation.latitude,
                              applicationBlock.currentLocation.longitude))
                    },
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            applicationBlock.currentLocation.latitude,
                            applicationBlock.currentLocation.longitude),
                        zoom: 15),
                    onMapCreated: (GoogleMapController controller) {
                      _mapController.complete(controller);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
