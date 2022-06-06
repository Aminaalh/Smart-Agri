import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/Screens/login/login_screen.dart';
import 'package:flutter_auth/Screens/signup/signup_screen.dart';
import 'package:flutter_auth/Screens/authentication_service.dart';

import 'package:flutter_auth/Screens/home/home_screen.dart';
import 'package:flutter_auth/Screens/home/map_screen.dart';
import 'package:flutter_auth/Screens/home/menu_screen.dart';
import 'package:flutter_auth/Screens/home/location_screen.dart';
import 'package:flutter_auth/Screens/home/qrscan_screen.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
        initialRoute: 'flutter_auth',
        routes: {
          'login_screen': (context) => LoginScreen(),
          'home_screen': (context) => HomeScreen(),
          'location_screen': (context) => LocationScreen(),
          'qrscan_screen': (context) => QRScanScreen(),
          'menu_screen': (context) => MenuScreen(),
          'map_screen': (context) => MapScreen()
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return SignUpScreen();
    }
    return LoginScreen();
  }
}
