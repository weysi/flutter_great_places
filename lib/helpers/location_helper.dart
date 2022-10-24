// AIzaSyD_XA8ex8muQL05llLTo1pK8hzv82wxLEk
//https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyCPJiH3colOgABoteuG4mxkxMBItSUUwrA
import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyD_XA8ex8muQL05llLTo1pK8hzv82wxLEk';

class LocationHelper {
  static String generateLocationPreview(double latitude, double longitutde) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitutde&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitutde&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyCPJiH3colOgABoteuG4mxkxMBItSUUwrA"));
    print(json.decode(response.body));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
