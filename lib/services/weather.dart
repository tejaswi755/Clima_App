import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

const apikey = '3bace6c84d0c464a77c2b59e833e829b';

class WeatherModel {
  Future<dynamic> cityWeather(String cityname) async {
    NetworkHelp networkhelp = NetworkHelp(
        url:
            'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apikey&units=metric');
    var weatherData = await networkhelp.getData();
    return weatherData;
  }

  Future<dynamic> getlocation() async {
    Location location = Location();
    await location.getcurrentlocation();

    NetworkHelp networkhelp = NetworkHelp(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var weatherData = await networkhelp.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
