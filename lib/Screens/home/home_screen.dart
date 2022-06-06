import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/rounded_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: 'Map',
                  onPressed: () {
                    Navigator.pushNamed(context, 'map_screen');
                  },
                ),
                RoundedButton(
                    colour: Colors.blueAccent,
                    title: 'QR Scan',
                    onPressed: () {
                      Navigator.pushNamed(context, 'qrscan_screen');
                    }),
              ]),
        ));
  }
}
