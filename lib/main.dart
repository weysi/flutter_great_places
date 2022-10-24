import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './providers/great_places.dart';
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/place_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      // create: (ctx) => GreatPlaces(),
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places ...',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // primarySwatch: Colors.indigo,
            colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.indigo,
          onPrimary: Colors.black,
          onSecondary: Colors.amber,
        )),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routName: (ctx) => PlaceDetailScreen()
        },
      ),
    );
  }
}
