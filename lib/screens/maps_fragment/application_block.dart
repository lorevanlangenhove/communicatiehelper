import 'package:communicatiehelper/screens/maps_fragment/place_autocomplete_model.dart';
import 'package:communicatiehelper/screens/maps_fragment/places_repository.dart';
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

abstract class AutocompleteState {
  const AutocompleteState();

  List<Object> get props => [];
}

class AutocompleteLoading extends AutocompleteState {}

class AutocompleteLoaded extends AutocompleteState {
  final List<PlaceAutocomplete> autocomplete;

  const AutocompleteLoaded({required this.autocomplete});

  @override
  List<Object> get props => [autocomplete];
}

class AutocompleteError extends AutocompleteState {}
