import 'dart:async';
import 'package:communicatiehelper/screens/maps_fragment/place.dart';
import 'package:communicatiehelper/screens/maps_fragment/place_search.dart';
import 'package:communicatiehelper/screens/maps_fragment/places_service.dart';
import 'package:flutter/foundation.dart';
import 'geolocator_servic.dart';

class ApplicationBlock with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placesService = PlaceService();
  var currentLocation;
  List<PlaceSearch> searchResults = <PlaceSearch>[];
  StreamController<Place> selectedLocation = StreamController<Place>();

  ApplicationBlock() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    selectedLocation.add(await placesService.getPlace(placeId));
    searchResults.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    selectedLocation.close();
  }
}
