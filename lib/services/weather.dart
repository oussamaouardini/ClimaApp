import 'package:clima/utilities/imports.dart';

class WeatherModel {


  Future<dynamic> getCityWeather(String cityName) async {
    var url  = "$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric" ;
    NetworkHelper networkHelper = NetworkHelper(url);
     var weatherData = await networkHelper.getData();
     return weatherData ;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper("$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData ;
  }
  Future<dynamic> getLocationWeatherByName(String city) async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper("$openWeatherMapURL?q=$city&appid=$apiKey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData ;
  }


  Future<dynamic> getFiveDays() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper("$openWeatherMapUrlForecast?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey");

    var weatherData = await networkHelper.getData();
    return weatherData ;
  }
  Future<dynamic> getFiveDaysByName(String cityName) async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper("$openWeatherMapUrlForecast?q=$cityName&appid=$apiKey");

    var weatherData = await networkHelper.getData();
    return weatherData ;
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
      return 'glace';
    } else if (temp > 20) {
      return 'short';
    } else if (temp < 10) {
      return 'glove';
    } else {
      return 'coat';
    }
  }
}
