import 'package:clima/screens/city_screen.dart';
import 'package:clima/utilities/imports.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;

  String weatherIcon;

  String cityName;
  WeatherModel weatherModel = WeatherModel();
  String weatherMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
//    dynamic temp = weatherData['main']['temp'];
//    temperature = temp;
//    var condition = weatherData['weather'][0]['id'];
//    weatherIcon =  weatherModel.getWeatherIcon(condition);
//    cityName = weatherData['name'];
//    weatherMessage = weatherModel.getMessage(temperature);

    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Eroor ';
        cityName = '';
        weatherMessage = 'Unable to get weather data';
        return;
      } else {

        try{
          double temp = weatherData['main']['temp'];
          temperature = temp.toInt();
          print('parsing');
        }catch(e){
          temperature = weatherData['main']['temp'];
          print('catch');
        }


        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weatherModel.getWeatherIcon(condition);
        cityName = weatherData['name'];
        weatherMessage = weatherModel.getMessage(temperature);
      }
    });
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weatherData = await weatherModel.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CityScreen()));
                        if (typedName != null) {
                          var weatherData =
                              await weatherModel.getCityWeather(typedName);
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
                      Expanded(
                        child: Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          weatherIcon,
                          style: kConditionTextStyle,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$weatherMessage in $cityName !",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
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
