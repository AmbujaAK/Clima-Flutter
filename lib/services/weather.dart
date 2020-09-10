import 'package:flutter_config/flutter_config.dart';

import '../services/location.dart';
import 'package:clima/services/networking.dart';

final apiKey = FlutterConfig.get('API_KEY');
final weatherBaseUrl = FlutterConfig.get('WEATHER_BASE_URL');

class WeatherModel {

  Future<dynamic> getWeatherLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(url:
    '$weatherBaseUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'
    );

    return await networkHelper.getDate();
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
