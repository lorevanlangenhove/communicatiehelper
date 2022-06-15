import 'package:communicatiehelper/screens/maps_fragment/place_autocomplete_model.dart';

abstract class BasePlacesRepository {
  Future<List<PlaceAutocomplete>?> getAutocomplete(String searchInput) async {}
}
