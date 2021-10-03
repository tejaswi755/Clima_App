import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:convert';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();

  LocationScreen({this.locationData});

  final String locationData;
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weathermodel = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityname;
  String weathermessage;

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        cityname = 'Null';
        weathermessage = 'data not fetched';
        return;
      }
      double temp = jsonDecode(weatherData)['main']['temp'];
      temperature = temp.toInt();
      weatherIcon = weathermodel
          .getWeatherIcon(jsonDecode(weatherData)['weather'][0]['id']);
      cityname = jsonDecode(weatherData)['name'];
      weathermessage = weathermodel.getMessage(temperature);
    });
  }

  @override
  void initState() {
    updateUI(widget.locationData);
    // print(widget.locationData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherdata = await weathermodel.getlocation();
                      updateUI(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if (typedCity != null) {
                        var weatherData =
                            await weathermodel.cityWeather(typedCity);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weathermessage in $cityname",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
