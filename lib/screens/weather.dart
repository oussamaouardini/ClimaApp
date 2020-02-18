import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class WeatherApp extends StatefulWidget {

  dynamic locationWeather;
  dynamic weatherDetails;
  int currentPage ;

  WeatherApp({this.locationWeather,this.currentPage,this.weatherDetails});
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {


  int  temperature  ;
  int  temperatureMax  ;
  int  temperatureMin  ;
  String weatherIcon;

  String cityName;
  WeatherModel weatherModel = WeatherModel();
  String weatherMessage;


  void updateUI(dynamic weather) {

    if (widget.weatherDetails == null) {
      temperature = 0;
      weatherIcon = 'Eroor ';
      cityName = '';
      weatherMessage = 'Unable to get weather data';
      return;
    } else {

      try{
        double temp = weather['main']['temp'];
        temperature = temp.toInt();
        print('parsing');
      }catch(e){
        temperature = weather['main']['temp'];
        print('catch');
      }
      var condition = weather['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      cityName = weather['name'];
      weatherMessage = weatherModel.getMessage(temperature);
    }

  }


  @override
  Widget build(BuildContext context) {

    updateUI(widget.weatherDetails);

    try{
      double temp = (widget.locationWeather[widget.currentPage]['main']['temp']-273.15) ;
      temperature = temp.toInt() ;
    }catch(e){
      temperature = (widget.locationWeather[widget.currentPage]['main']['temp']-273.15) ;
    }
    try{
      double temp1 = (widget.locationWeather[widget.currentPage]['main']['temp_min']-273.15) ;
      temperatureMin = temp1.toInt() ;
    }catch(e){
      temperatureMin = (widget.locationWeather[widget.currentPage]['main']['temp_min']-273.15) ;
    }
    try{
      double temp2 = (widget.locationWeather[widget.currentPage]['main']['temp_max']-273.15) ;
      temperatureMax = temp2.toInt() ;
    }catch(e){
      temperatureMax = (widget.locationWeather[widget.currentPage]['main']['temp_max']-273.15) ;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Color(0xFFe6ebf2),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).viewPadding.top + 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          cart(DateTime.parse(widget.locationWeather[widget.currentPage]["dt_txt"]).day,DateTime.parse(widget.locationWeather[widget.currentPage]["dt_txt"]).month),
                          cart(DateTime.parse(widget.locationWeather[1]["dt_txt"]).day,DateTime.parse(widget.locationWeather[widget.currentPage]["dt_txt"]).month),
                          cart(DateTime.parse(widget.locationWeather[2]["dt_txt"]).day,DateTime.parse(widget.locationWeather[widget.currentPage]["dt_txt"]).month),
                          cart(DateTime.parse(widget.locationWeather[3]["dt_txt"]).day,DateTime.parse(widget.locationWeather[widget.currentPage]["dt_txt"]).month),
                          cart(DateTime.parse(widget.locationWeather[4]["dt_txt"]).day,DateTime.parse(widget.locationWeather[widget.currentPage]["dt_txt"]).month),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFe6ebf2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(-3, -3),
                                  color: Colors.white.withOpacity(.7)),
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(3, 3),
                                  color: Colors.black.withOpacity(.15))
                            ]),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top:8.0,left: 8.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${widget.weatherDetails['name']}",style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0
                                      ),),
                                    ],),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text("weather",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 5.0,),
                                        Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFe6ebf2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    offset: Offset(-3, -3),
                                                    color:
                                                    Colors.white.withOpacity(.7)),
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    offset: Offset(3, 3),
                                                    color:
                                                    Colors.black.withOpacity(.15))
                                              ]),
                                          child: Icon(
                                            FontAwesome.mixcloud,
                                            color: Colors.black.withOpacity(.5),
                                            size: 30.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      /*(T(°F) - 32) × 5/9*/
                                      Text("${this.temperature}°C",
                                          style: TextStyle(
                                              fontFamily: "nunito",
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 15.0)),
                                      Row(
                                        children: <Widget>[
                                          Text("${this.temperatureMax}°C",
                                              style: TextStyle(
                                                  fontFamily: "nunito",
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black.withOpacity(.5),
                                                  fontSize: 15.0)),
                                          Text("  ${this.temperatureMin}°C",
                                              style: TextStyle(
                                                  fontFamily: "nunito",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black.withOpacity(.3),
                                                  fontSize: 15.0)),
                                        ],
                                      )
                                    ],
                                  ),

                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text( widget.locationWeather[widget.currentPage]['weather'][widget.currentPage]['main'] +":"+widget.locationWeather[widget.currentPage]['weather'][widget.currentPage]['description'],
                                      style: TextStyle(
                                          fontFamily: "nunito",
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 15.0)),

                                ],
                              ),
                            ],
                          ),
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                        height: 90.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFe6ebf2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(-3, -3),
                                  color: Colors.white.withOpacity(.7)),
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(3, 3),
                                  color: Colors.black.withOpacity(.15))
                            ]),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFe6ebf2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(-3, -3),
                                            color:
                                            Colors.white.withOpacity(.7)),
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(3, 3),
                                            color:
                                            Colors.black.withOpacity(.15))
                                      ]),
                                  child: Icon(
                                    FontAwesome.leaf,
                                    color: Colors.black.withOpacity(.5),
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Humidity",
                                      style: TextStyle(
                                          fontFamily: "nunito",
                                          color: Colors.black.withOpacity(.5),
                                          fontSize: 15.0)),
                                  Text("${widget.locationWeather[widget.currentPage]['main']['humidity']}%",
                                      style: TextStyle(
                                          fontFamily: "nunito",
                                          color: Colors.black.withOpacity(.5),
                                          fontSize: 15.0))
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                        height: 90.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFe6ebf2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(-3, -3),
                                  color: Colors.white.withOpacity(.7)),
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(3, 3),
                                  color: Colors.black.withOpacity(.15))
                            ]),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFe6ebf2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(-3, -3),
                                            color:
                                            Colors.white.withOpacity(.7)),
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(3, 3),
                                            color:
                                            Colors.black.withOpacity(.15))
                                      ]),
                                  child: Icon(
                                    FontAwesome.compress,
                                    color: Colors.black.withOpacity(.5),
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Pressure",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0)),
                                  Text("${widget.locationWeather[widget.currentPage]['main']['pressure']}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0))
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                        height: 90.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFe6ebf2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(-3, -3),
                                  color: Colors.white.withOpacity(.7)),
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(3, 3),
                                  color: Colors.black.withOpacity(.15))
                            ]),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFe6ebf2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(-3, -3),
                                            color:
                                            Colors.white.withOpacity(.7)),
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(3, 3),
                                            color:
                                            Colors.black.withOpacity(.15))
                                      ]),
                                  child: Icon(
                                    Icons.golf_course,
                                    color: Colors.black.withOpacity(.5),
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Wind",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0)),
                                  Text("${widget.locationWeather[widget.currentPage]['wind']['speed']}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0))
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                        height: 90.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFe6ebf2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(-3, -3),
                                  color: Colors.white.withOpacity(.7)),
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(3, 3),
                                  color: Colors.black.withOpacity(.15))
                            ]),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFe6ebf2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(-3, -3),
                                            color:
                                            Colors.white.withOpacity(.7)),
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(3, 3),
                                            color:
                                            Colors.black.withOpacity(.15))
                                      ]),
                                  child: Icon(
                                    Icons.directions_boat,
                                    color: Colors.black.withOpacity(.5),
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Sea Level",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0)),
                                  Text("${widget.locationWeather[widget.currentPage]['main']['sea_level']}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0))
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.warning,color: Colors.red,size: 30.0,),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: Text(
                              "$weatherMessage in $cityName !",
                              textAlign: TextAlign.right,
                              style: kMessageTextStyle,
                            ),
                          ),
                        ),
                      ],

                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Current Tempreture",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.5),
                                    fontFamily: "nunito",
                                    fontSize: 15.0)),
                            Text("${widget.locationWeather[widget.currentPage]['main']['temp']}°K -- ${this.temperature}°C  at   ${widget.locationWeather[widget.currentPage]['dt_txt']} ",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.6),
                                    fontFamily: "nunito",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}



class MySmartWeather extends StatelessWidget {

  dynamic locationWeather;
  dynamic weatherDetails;
  int currentPage ;

  MySmartWeather({this.locationWeather,this.currentPage,this.weatherDetails});
  int  temperature  ;
  int  temperatureMax  ;
  int  temperatureMin  ;
  String weatherIcon;

  String cityName;
  WeatherModel weatherModel = WeatherModel();
  String weatherMessage;

  void updateUI(dynamic weather) {

      if (weatherDetails == null) {
        temperature = 0;
        weatherIcon = 'Eroor ';
        cityName = '';
        weatherMessage = 'Unable to get weather data';
        return;
      } else {

        try{
          double temp = weather['main']['temp'];
          temperature = temp.toInt();
          print('parsing');
        }catch(e){
          temperature = weather['main']['temp'];
          print('catch');
        }
        var condition = weather['weather'][0]['id'];
        weatherIcon = weatherModel.getWeatherIcon(condition);
        cityName = weather['name'];
        weatherMessage = weatherModel.getMessage(temperature);
      }

  }



  @override
  Widget build(BuildContext context) {

    updateUI(this.weatherDetails);

    try{
      double temp = (this.locationWeather[this.currentPage]['main']['temp']-273.15) ;
      temperature = temp.toInt() ;
    }catch(e){
      temperature = (this.locationWeather[this.currentPage]['main']['temp']-273.15) ;
    }
    try{
      double temp1 = (this.locationWeather[this.currentPage]['main']['temp_min']-273.15) ;
      temperatureMin = temp1.toInt() ;
    }catch(e){
      temperatureMin = (this.locationWeather[this.currentPage]['main']['temp_min']-273.15) ;
    }
    try{
      double temp2 = (this.locationWeather[this.currentPage]['main']['temp_max']-273.15) ;
      temperatureMax = temp2.toInt() ;
    }catch(e){
      temperatureMax = (this.locationWeather[this.currentPage]['main']['temp_max']-273.15) ;
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Color(0xFFe6ebf2),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).viewPadding.top + 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          cart(DateTime.parse(this.locationWeather[this.currentPage]["dt_txt"]).day,DateTime.parse(this.locationWeather[this.currentPage]["dt_txt"]).month),
                          cart(DateTime.parse(this.locationWeather[1]["dt_txt"]).day,DateTime.parse(this.locationWeather[this.currentPage]["dt_txt"]).month),
                          cart(DateTime.parse(this.locationWeather[2]["dt_txt"]).day,DateTime.parse(this.locationWeather[this.currentPage]["dt_txt"]).month),
                          cart(DateTime.parse(this.locationWeather[3]["dt_txt"]).day,DateTime.parse(this.locationWeather[this.currentPage]["dt_txt"]).month),
                          cart(DateTime.parse(this.locationWeather[4]["dt_txt"]).day,DateTime.parse(this.locationWeather[this.currentPage]["dt_txt"]).month),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFe6ebf2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(-3, -3),
                                  color: Colors.white.withOpacity(.7)),
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(3, 3),
                                  color: Colors.black.withOpacity(.15))
                            ]),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top:8.0,left: 8.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${this.weatherDetails['name']}",style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0
                                      ),),
                                    ],),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text("weather",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 5.0,),
                                        Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFe6ebf2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    offset: Offset(-3, -3),
                                                    color:
                                                    Colors.white.withOpacity(.7)),
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    offset: Offset(3, 3),
                                                    color:
                                                    Colors.black.withOpacity(.15))
                                              ]),
                                          child: Icon(
                                            FontAwesome.mixcloud,
                                            color: Colors.black.withOpacity(.5),
                                            size: 30.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      /*(T(°F) - 32) × 5/9*/
                                      Text("${this.temperature}°C",
                                          style: TextStyle(
                                              fontFamily: "nunito",
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 15.0)),
                                      Row(
                                        children: <Widget>[
                                          Text("${this.temperatureMax}°C",
                                              style: TextStyle(
                                                  fontFamily: "nunito",
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black.withOpacity(.5),
                                                  fontSize: 15.0)),
                                          Text("  ${this.temperatureMin}°C",
                                              style: TextStyle(
                                                  fontFamily: "nunito",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black.withOpacity(.3),
                                                  fontSize: 15.0)),
                                        ],
                                      )
                                    ],
                                  ),

                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text( this.locationWeather[this.currentPage]['weather'][this.currentPage]['main'] +":"+this.locationWeather[this.currentPage]['weather'][this.currentPage]['description'],
                                      style: TextStyle(
                                          fontFamily: "nunito",
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 15.0)),

                                ],
                              ),
                            ],
                          ),
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                        height: 90.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFe6ebf2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(-3, -3),
                                  color: Colors.white.withOpacity(.7)),
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(3, 3),
                                  color: Colors.black.withOpacity(.15))
                            ]),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFe6ebf2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(-3, -3),
                                            color:
                                            Colors.white.withOpacity(.7)),
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(3, 3),
                                            color:
                                            Colors.black.withOpacity(.15))
                                      ]),
                                  child: Icon(
                                    FontAwesome.leaf,
                                    color: Colors.black.withOpacity(.5),
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Humidity",
                                      style: TextStyle(
                                          fontFamily: "nunito",
                                          color: Colors.black.withOpacity(.5),
                                          fontSize: 15.0)),
                                  Text("${this.locationWeather[this.currentPage]['main']['humidity']}%",
                                      style: TextStyle(
                                          fontFamily: "nunito",
                                          color: Colors.black.withOpacity(.5),
                                          fontSize: 15.0))
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                        height: 90.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFe6ebf2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(-3, -3),
                                  color: Colors.white.withOpacity(.7)),
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(3, 3),
                                  color: Colors.black.withOpacity(.15))
                            ]),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFe6ebf2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(-3, -3),
                                            color:
                                            Colors.white.withOpacity(.7)),
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(3, 3),
                                            color:
                                            Colors.black.withOpacity(.15))
                                      ]),
                                  child: Icon(
                                    FontAwesome.compress,
                                    color: Colors.black.withOpacity(.5),
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Pressure",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0)),
                                  Text("${this.locationWeather[this.currentPage]['main']['pressure']}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0))
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                        height: 90.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFe6ebf2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(-3, -3),
                                  color: Colors.white.withOpacity(.7)),
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(3, 3),
                                  color: Colors.black.withOpacity(.15))
                            ]),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFe6ebf2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(-3, -3),
                                            color:
                                            Colors.white.withOpacity(.7)),
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(3, 3),
                                            color:
                                            Colors.black.withOpacity(.15))
                                      ]),
                                  child: Icon(
                                    Icons.golf_course,
                                    color: Colors.black.withOpacity(.5),
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Wind",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0)),
                                  Text("${this.locationWeather[this.currentPage]['wind']['speed']}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0))
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                        height: 90.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xFFe6ebf2),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(-3, -3),
                                  color: Colors.white.withOpacity(.7)),
                              BoxShadow(
                                  blurRadius: 5.0,
                                  offset: Offset(3, 3),
                                  color: Colors.black.withOpacity(.15))
                            ]),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFe6ebf2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(-3, -3),
                                            color:
                                            Colors.white.withOpacity(.7)),
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            offset: Offset(3, 3),
                                            color:
                                            Colors.black.withOpacity(.15))
                                      ]),
                                  child: Icon(
                                    Icons.directions_boat,
                                    color: Colors.black.withOpacity(.5),
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Sea Level",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0)),
                                  Text("${this.locationWeather[this.currentPage]['main']['sea_level']}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontFamily: "nunito",
                                          fontSize: 15.0))
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.warning,color: Colors.red,size: 30.0,),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: Text(
                              "$weatherMessage in $cityName !",
                              textAlign: TextAlign.right,
                                style: kMessageTextStyle,
                            ),
                          ),
                        ),
                      ],

                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Current Tempreture",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.5),
                                    fontFamily: "nunito",
                                    fontSize: 15.0)),
                            Text("${this.locationWeather[this.currentPage]['main']['temp']}°K -- ${this.temperature}°C  at   ${this.locationWeather[this.currentPage]['dt_txt']} ",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.6),
                                    fontFamily: "nunito",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget cart(int day , int month) {
    String mon = "" ;
    switch(month){
      case 1 : mon = "January";
        break ;
      case 2 :mon = "February";
        break ;
      case 3 :mon = "March ";
        break ;
      case 4 :mon = "April ";
        break ;
      case 5 :mon = "May";
        break ;
      case 6 :mon = "June";
        break ;
      case 7 :mon = "July";
        break ;
      case 8 :mon = "Auguest";
        break ;
      case 9 :mon = "September";
        break ;
        case 10 :mon = "October";
      break ;
      case 11 :mon = "November";
        break ;
      case 12 :mon = "December";
        break ;

    }


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "$day",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Text(
                "$mon",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget cart(int day , int month) {
  String mon = "" ;
  switch(month){
    case 1 : mon = "January";
    break ;
    case 2 :mon = "February";
    break ;
    case 3 :mon = "March ";
    break ;
    case 4 :mon = "April ";
    break ;
    case 5 :mon = "May";
    break ;
    case 6 :mon = "June";
    break ;
    case 7 :mon = "July";
    break ;
    case 8 :mon = "Auguest";
    break ;
    case 9 :mon = "September";
    break ;
    case 10 :mon = "October";
    break ;
    case 11 :mon = "November";
    break ;
    case 12 :mon = "December";
    break ;

  }


  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: (){
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "$day",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Text(
              "$mon",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ],
        ),
      ),
    ),
  );
}