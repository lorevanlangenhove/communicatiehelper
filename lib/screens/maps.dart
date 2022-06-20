import 'dart:async';
import 'package:communicatiehelper/screens/maps_fragment/application_block.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'maps_fragment/place.dart';

class MapsPage extends StatefulWidget {
  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _mapController = Completer();
  TextEditingController _searchController = TextEditingController();
  late StreamSubscription locationSubscription;

  List<LatLng> polygonLatLngs = <LatLng>[];

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 12),
      ),
    );
  }

  @override
  void initState() {
    final applicationBlock =
        Provider.of<ApplicationBlock>(context, listen: false);
    locationSubscription =
        applicationBlock.selectedLocation.stream.listen((place) {
      if (place != null) {
        _goToPlace(place);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBlock =
        Provider.of<ApplicationBlock>(context, listen: false);
    applicationBlock.dispose();
    locationSubscription.cancel();
    super.dispose();
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
                            applicationBlock.searchPlaces(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 600,
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
                    if (applicationBlock.searchResults != null &&
                        applicationBlock.searchResults.length != 0)
                      Container(
                        height: 300,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            backgroundBlendMode: BlendMode.darken),
                      ),
                    if (applicationBlock.searchResults != null &&
                        applicationBlock.searchResults.length != 0)
                      Container(
                        height: 300,
                        child: ListView.builder(
                          itemCount: applicationBlock.searchResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                applicationBlock
                                    .searchResults[index].description,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                applicationBlock.setSelectedLocation(
                                    applicationBlock
                                        .searchResults[index].placeId);
                              },
                            );
                          },
                        ),
                      )
                  ],
                ),
              ],
            ),
    );
  }
}
