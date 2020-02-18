import 'package:clima/screens/weather.dart';
import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 15.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);


const apiKey = "292c6308e138b3b9f8915ffceb26adf4";
const openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";
const openWeatherMapUrlForecast = "https://api.openweathermap.org/data/2.5/forecast";
const  kTextFieldInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    icon: Icon(Icons.location_city,
      color: Colors.white,),
    hintText: 'Enter City Name',
    hintStyle: TextStyle(
        color: Colors.grey
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide.none
    )
);

