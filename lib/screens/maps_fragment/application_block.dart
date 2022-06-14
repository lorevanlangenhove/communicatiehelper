import 'package:communicatiehelper/screens/maps_fragment/places_service.dart';
import 'package:flutter/foundation.dart';
import 'geolocator_servic.dart';

class ApplicationBlock with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placesService = PlaceService();
  var currentLocation;

  ApplicationBlock() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    notifyListeners();
  }
}
