import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {

    dynamic weatherData = await WeatherModel().getFiveDays();
    int dr = weatherData['list'].length;

    DateTime dt = DateTime.parse(weatherData['list'][0]["dt_txt"]) ;

List<dynamic> dates = [];



    for(int i = 0 ; i < dr ; i++ ){
       var date =  dt.difference(DateTime.parse(weatherData['list'][i]["dt_txt"]));
       if(date.inHours % 24 == 0){
         dates.add(weatherData['list'][i]);
       }
    }

    //  Navigator.push(context, MaterialPageRoute(builder:(context)=> LocationScreen(locationWeather: weatherData,) ));
  }

  @override
  Widget build(BuildContext context) {
    getLocationData();
    return Scaffold(
appBar: AppBar(
  title: Text("oussama"),
),
    );
  }
}
