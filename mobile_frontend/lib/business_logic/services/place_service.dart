import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mobile_frontend/secret_keys.dart';

class SearchLocation {
  String lat;
  String lon;

  SearchLocation({
    this.lat,
    this.lon,
  });
}

class Suggestion {
  final String placeId;
  final String description;
  // final String lat;
  // final String lon;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = kGooglePlaceAndroidKey;
  static final String iosKey = kGooglePlaceIosKey;
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:nz&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(
                  p['place_id'],
                  p['description'],
                ))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<SearchLocation> getLocationDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        String lat =
            result['result']['geometry']['location']['lat']?.toString();
        String lon =
            result['result']['geometry']['location']['lng']?.toString();
        final place = SearchLocation(lat: lat, lon: lon);
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
