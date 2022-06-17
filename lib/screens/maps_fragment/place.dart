import 'package:communicatiehelper/screens/maps_fragment/geometry.dart';

class Place {
  final Geometry geometry;
  final String name;
  final String vicinity;

  Place({required this.geometry, required this.name, required this.vicinity});

  factory Place.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Place(
        geometry: Geometry.fromJson(parsedJson['geometry']),
        name: parsedJson['formatted_address'],
        vicinity: parsedJson['vicinity']);
  }
}
