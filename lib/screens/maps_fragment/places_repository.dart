import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlaceService {
  final String key = 'AIzaSyDtMtQsB6rc-0vN1E_qVpWWX-giyMpeAzg';

  Future<String> getAutocomplete(String search) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&language=nl&types=%28cities%29&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['predictions'][0]['place_id'] as String;
    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getAutocomplete(input);
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    print(jsonResult);
    return jsonResult;
  }
}
