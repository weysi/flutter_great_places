import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  late double lat;
  late double lng;
  void _showPreview(double lt, double lg) {
    var staticMapImageUrl;
    final locData = Location().getLocation();
    locData.then((value) {
      staticMapImageUrl = LocationHelper.generateLocationPreview(lt, lg);
      lat = value.latitude!;
      lng = value.longitude!;

      print('${value.latitude} / ${value.longitude} ss');
    }).whenComplete(() {
      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = Location().getLocation();
      locData.then((value) {
        _showPreview(value.latitude!, value.longitude!);
        widget.onSelectPlace(value.latitude, value.longitude);
      });
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    print('Selected Latitude : ${selectedLocation.latitude}');
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text('No Location Chosen', textAlign: TextAlign.center)
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on  Map'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
