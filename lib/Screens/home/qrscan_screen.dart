import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_auth/Screens/home/location.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({Key key}) : super(key: key);

  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}

final _database = FirebaseDatabase.instance;
DatabaseReference ref = _database.ref("");

class _QRScanScreenState extends State<QRScanScreen> {
  String _scanBarcode = '';

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    String Localisation;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (barcodeScanRes.startsWith('NodeCode:') == false) {
        barcodeScanRes = "Doesn't match\n our \nproduct's code\n";
      }
      // try acquiring gps position
      else {
        // take the code
        barcodeScanRes = (barcodeScanRes.split("NodeCode:"))[1];

        try {
          final gpsPos = await Location.determinePosition();
          Localisation = "\nLatitude :" +
              gpsPos.latitude.toString() +
              "\nLongitude :" +
              gpsPos.longitude.toString();

          // check internet connexion and Update database
          /*
            try {
              final result = await InternetAddress.lookup('example.com');
              if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                print('connected');
              }
            } on SocketException catch (_) {
              print('not connected');
            }
          */

          try {
            final result = await InternetAddress.lookup('www.google.com');

            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
              await ref.update({
                barcodeScanRes: {
                  "lat": gpsPos.latitude,
                  "lng": gpsPos.longitude
                }
              });

              barcodeScanRes = barcodeScanRes + Localisation;
            } else {
              barcodeScanRes = "No Internet Connexion Found";
            }
          } on SocketException catch (_) {
            barcodeScanRes = "No Internet Connexion Found";
          } catch (error) {
            barcodeScanRes = error.toString();
          }
        } catch (error) {
          barcodeScanRes = error.toString();
        }
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes = "";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Qr&Bar code scan')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () => scanBarcodeNormal(),
                            child: Text('Start barcode scan')),
                        ElevatedButton(
                            onPressed: () => scanQR(),
                            child: Text('Start QR scan')),
                        Text('$_scanBarcode\n', style: TextStyle(fontSize: 20))
                      ]));
            })));
  }
}
