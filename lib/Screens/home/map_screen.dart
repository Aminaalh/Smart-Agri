import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter_auth/Screens/sensors/sensor_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

final _database = FirebaseDatabase.instance;
Map json = {};
DatabaseReference ref = _database.ref("");

class _MapScreenState extends State<MapScreen> {
  List<Marker> markers = [];
  void markersFromDB() async {
    DatabaseEvent event = await ref.once();
    Map<String, dynamic> map = jsonDecode(jsonEncode(event.snapshot.value));
    map.forEach((key, jsonString) {
      print('$key: $jsonString'); // jsonString = {img1:value1}
      // json = jsonString;
      var m = Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(jsonString['lat'], jsonString['lng']),
        builder: (ctx) => Container(
            child: Material(
          color: Colors.transparent,
          child: IconButton(
            color: Color.fromARGB(126, 16, 138, 77),
            icon: Icon(Icons.location_on_rounded),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SensorScreen(data: key)));
            },
          ),
        )),
      );
      markers.add(m);

      print("*******");
      print(markers);
    });
  }

  @override
  void initState() {
    markersFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(33.983611, -6.868427),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return Text("");
          },
        ),
        MarkerLayerOptions(markers: markers),
      ],
    );
  }

  void floatingActionButton() {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => SensorScreen()));
  }
}
