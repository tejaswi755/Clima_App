import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future getlocationData() async {
    WeatherModel weathermodel = WeatherModel();
    var weatherData = await weathermodel.getlocation();
     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          locationData: weatherData,
        ),
      ),
    );
  }

  @override
  void initState() {
    getlocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
