import 'package:flutter/material.dart';
import 'MyCustomButton.dart';
import 'package:flutter_auth/model/Data.dart';

class MyMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Plantado",
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: "Montserrat",
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/background1.jpg"),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    "'Being on Top of your Plants has never been easier'",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image(
                    width: 180,
                    height: 180,
                    image: AssetImage("assets/leafi 1.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    "Plantado",
                    style: TextStyle(fontSize: 60, color: Color(0xFF0E0E0E)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      print("tapped");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SensorScreen()));
                    },
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Opacity(
                        opacity: 0.9,
                        child: Container(
                          width: 130,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 4.0,
                                  offset: Offset(0.0, 4.0))
                            ],
                            color: Color(0xE64057F5),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Monitor your Plants with this interactive IoT Tracker",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SensorScreen extends StatelessWidget {
  const SensorScreen({this.data});

  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/background.jpg"),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            data,
            style: TextStyle(color: Colors.grey),
          ),
          brightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  height: 100,
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Plantado",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                  ),
                ),
              ),
              MySidebar(),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                MyCustomButton(
                  id: data,
                  buttonName: "Temperature",
                  image: "temperature.png",
                  // value: "29",
                  color: 0xE64057F5,
                ),
                MyCustomButton(
                  id: data,
                  buttonName: "Humidity",
                  image: "humidity.png",
                  // value: "61",
                  color: 0xE6FEABD7,
                ),
                MyCustomButton(
                  id: data,
                  buttonName: "PH",
                  image: "ph.png",
                  // value: "61",
                  color: 0xE64057F5,
                ),
                MyCustomButton(
                  id: data,
                  buttonName: "RainFall",
                  image: "cloud-rain.png",
                  // value: "61",
                  color: 0xE6FEABD7,
                ),
                MyCustomButton(
                  id: data,
                  buttonName: "Nitrogen",
                  image: "n.png",
                  // value: "61",
                  color: 0xE64057F5,
                ),
                MyCustomButton(
                  id: data,
                  buttonName: "Phosphorus",
                  image: "p.png",
                  // value: "61",
                  color: 0xE6FEABD7,
                ),
                MyCustomButton(
                  id: data,
                  buttonName: "Potassium",
                  image: "k.png",
                  // value: "61",
                  color: 0xE64057F5,
                ),
                // MyCustomButton(
                //   buttonName: "Watering",
                //   image: "water.png",
                //   value: "water",
                //   color: 0xE66AD6E7,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MySidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutScreen()),
            );
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15),
                child: Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
              ),
              Container(
                child: Text(
                  "About",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
//        Divider(),
//        InkWell(
//          onTap: () {
//            Navigator.of(context).pop();
//          },
//          child: Row(
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.all(15),
//                child: Icon(
//                  Icons.home,
//                  color: Colors.grey,
//                ),
//              ),
//              Container(
//                child: Text(
//                  "Splash Screen",
//                  style: TextStyle(fontSize: 15),
//                ),
//              ),
//            ],
//          ),
//        ),
        Divider(),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Credits"),
                content: Text(
                    "An IoT app by Vignesh and Sanjivy for Android App Development Hackathon."),
              ),
              barrierDismissible: true,
            );
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15),
                child: Icon(
                  Icons.announcement,
                  color: Colors.grey,
                ),
              ),
              Container(
                child: Text(
                  "Credits",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/background.jpg"),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("About"),
          brightness: Brightness.dark,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Text(
              "Welcome to Plantado - An IOT based plant monitoring system.\n\n"
              "Monitor the sunlight and water content of your plants and get alerts when you need to act.\n\n"
              "Description:\n\n"
              "In today's Busy world , we forget to Nourish and water plants that makes our home clean and organic. Think about it what if your plant are able to tell you when they are happy and when they require proper attention . It would be Great right! It would be really helpful if we get a notification on our phones about our plant's health and needs . On considering this,we proposed the idea of building an iot based application which can monitor your plants in real time.\n\n"
              "It uses the following:\n\n"
              "* Arduino UNO(an open source hardware / platdorm for projects)\n"
              "* DHT11 : Temperature and Humidity sensor\n"
              "* YL - 38 + YL - 69 Soil moisture sensor\n"
              "* Water Motor Pump - For watering the plant\n\n"
              "Main Objective : Monitoring the plant health status using a set of sensors.\n\n"
              "How it works:\n\n"
              "The above mentioned sensors are connected to the Arduino . And these sensors lively measures the temperature,humidity and soil moisture content and sends the data lively to the Firebase cloud and the app receives the information from it since it is integrated.",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
