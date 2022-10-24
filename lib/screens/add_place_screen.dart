import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/image_input.dart';
import '../providers/great_places.dart';
import '../widgets/location_input.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;
  _selectImage(File? pickedImage) {
    _pickedImage = pickedImage!;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longtitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Place '),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration:const  InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: _titleController,
                  ),
                 const  SizedBox(
                    height: 10,
                  ),
                  ImageInput(onSelectImage: _selectImage),
                  const SizedBox(
                    height: 10,
                  ),
                  LocationInput(_selectPlace)
                ],
              ),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: _savePlace,
          style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Theme.of(context).colorScheme.onSecondary,
              onPrimary: Theme.of(context).colorScheme.onPrimary),
          label: const Text(
            'Add Place',
          ),
          icon:const  Icon(Icons.add),
        )
      ]),
    );
  }
}
