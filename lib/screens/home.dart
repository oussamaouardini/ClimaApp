import 'package:clima/utilities/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class Weather extends StatefulWidget {

  dynamic locationWeather;
  dynamic weatherDetails;
  int currentPage;

  Weather({this.locationWeather, this.currentPage, this.weatherDetails});

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  int currentPage = 0 ;
  String currentTitle = "Home" ;
  Color currentColor = Colors.deepPurple ;
  bool loading = false  ;

  int temperature;

  int temperatureMax;

  int temperatureMin;

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
      try {
        double temp = weather['main']['temp'];
        temperature = temp.toInt();
      } catch (e) {
        temperature = weather['main']['temp'];
      }
      var condition = weather['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      cityName = weather['name'];
      weatherMessage = weatherModel.getMessage(temperature);

      try {
        double temp =
        (widget.locationWeather[widget.currentPage]['main']['temp'] - 273.15);
        temperature = temp.toInt();
      } catch (e) {
        temperature =
        (widget.locationWeather[widget.currentPage]['main']['temp'] - 273.15);
      }
      try {
        double temp1 = (widget.locationWeather[widget.currentPage]['main']
        ['temp_min'] -
            273.15);
        temperatureMin = temp1.toInt();
      } catch (e) {
        temperatureMin = (widget.locationWeather[widget.currentPage]['main']
        ['temp_min'] -
            273.15);
      }
      try {
        double temp2 = (widget.locationWeather[widget.currentPage]['main']
        ['temp_max'] -
            273.15);
        temperatureMax = temp2.toInt();
      } catch (e) {
        temperatureMax = (widget.locationWeather[widget.currentPage]['main']
        ['temp_max'] -
            273.15);
      }

    }
  }
  void update(dynamic weather) {
    if (widget.weatherDetails == null) {
      temperature = 0;
      weatherIcon = 'Eroor ';
      cityName = '';
      weatherMessage = 'Unable to get weather data';
      return;
    } else {
      try {
        double temp = weather['main']['temp'];
        temperature = temp.toInt();
      } catch (e) {
        temperature = weather['main']['temp'];
      }
      var condition = weather['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      cityName = weather['name'];
      weatherMessage = weatherModel.getMessage(temperature);

      try {
        double temp =
        (widget.locationWeather[widget.currentPage]['main']['temp'] - 273.15);
        temperature = temp.toInt();
      } catch (e) {
        temperature =
        (widget.locationWeather[widget.currentPage]['main']['temp'] - 273.15);
      }
      try {
        double temp1 = (widget.locationWeather[widget.currentPage]['main']
        ['temp_min'] -
            273.15);
        temperatureMin = temp1.toInt();
      } catch (e) {
        temperatureMin = (widget.locationWeather[widget.currentPage]['main']
        ['temp_min'] -
            273.15);
      }
      try {
        double temp2 = (widget.locationWeather[widget.currentPage]['main']
        ['temp_max'] -
            273.15);
        temperatureMax = temp2.toInt();
      } catch (e) {
        temperatureMax = (widget.locationWeather[widget.currentPage]['main']
        ['temp_max'] -
            273.15);
      }

    }
  }
  List<bool> days = [
    true,
    false,
    false,
    false,
    false,
  ];

  Widget appBarTitle = new Text("Climate Predictor");
  Icon actionIcon = new Icon(Icons.search);
  final searchController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.weatherDetails);
  }
  var focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    updateUI(widget.weatherDetails);
    SizeConfig().init(context);
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Directionality(
        textDirection:  ( data.locale.toString() == "en_US" ) ? TextDirection.ltr : TextDirection.rtl ,
        child: GestureDetector(
          onPanUpdate: (details){
            if(details.delta.dx < 0)
            {
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => Stats()));
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:15.0),
                      child: IconButton(icon: Icon(Icons.more_vert,color: Colors.black,),onPressed: (){
                        print('object');
                      },),
                    ),
                  ],
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal*65,
                  height: SizeConfig.blockSizeVertical*40,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 9.0,
                      ),]
                  ),
                  child: Column(
                    children: <Widget>[
                      ClipRect(
                        child : Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              ClipRect(child: Container(height: SizeConfig.blockSizeVertical*2.2,child: Text("°", style: TextStyle(fontSize: 50,height: 1)))),
                              ClipRect(child: Container(height: SizeConfig.blockSizeVertical*17,child: Text("${this.temperature}", style: TextStyle(fontSize: 150, color: Color(0xFF606060),height: 1),))),
                            ],
                          ),
                        ),
                      ),
                      Text(DateTime.parse(
                          widget.locationWeather[0]
                          ["dt_txt"])
                          .day.toString()+"/"+DateTime.parse(
                          widget.locationWeather[0]
                          ["dt_txt"])
                          .month.toString(), style: TextStyle(fontSize: 14,color: Color(0xFFCACACA)),),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(widget.locationWeather[widget
                            .currentPage]['weather']
                        [0]
                        ['description'], style: TextStyle(fontSize: 18,color:Color(0xFF696969),),),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical*3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0,top: 3.0,right: 10.0,bottom: 0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.location_on,color: Color(0xFFFF7E7E),size: 30.0,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text("${widget.weatherDetails['name']}", style: TextStyle(fontSize: 30.0,color:Color(0xFF696969)),),
                                ),
                              ],
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: ClipRect(
                                    child: Container(
                                      height: 20,
                                      child: Text("Last updated: 4:47 PM", style: TextStyle(fontSize: 14, height: 1.4,color: Color(0xFF9B9B9B)),),
                                    )
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    height: 90,
                    child: new ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            width: 50,
                            decoration: new BoxDecoration(
                              color: Color(0xFFFF7F7E),
                              borderRadius: new BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Now", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                                Icon(Icons.wb_cloudy, color: Colors.white,),
                                Padding(
                                  padding: const EdgeInsets.only(left:8,top: 8,right: 8,bottom: 0),
                                  child: Text("24", style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Container(
                              width: 80,
                              decoration: new BoxDecoration(
                                color: Color(0xFFFF7F7E),
                                borderRadius: new BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("5:00 PM", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                  Icon(Icons.wb_cloudy, color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8,top: 8,right: 8,bottom: 0),
                                    child: Text("24", style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),),
                                  )
                                ],
                              ),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Container(
                              width: 80,
                              decoration: new BoxDecoration(
                                color: Color(0xFF463B97),
                                borderRadius: new BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("5:00 PM", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                  Icon(Icons.wb_cloudy, color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8,top: 8,right: 8,bottom: 0),
                                    child: Text("24", style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),),
                                  )
                                ],
                              ),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Container(
                              width: 80,
                              decoration: new BoxDecoration(
                                color: Color(0xFF463B97),
                                borderRadius: new BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("5:00 PM", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                  Icon(Icons.wb_cloudy, color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8,top: 8,right: 8,bottom: 0),
                                    child: Text("24", style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),),
                                  )
                                ],
                              ),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Container(
                              width: 80,
                              decoration: new BoxDecoration(
                                color: Color(0xFF463B97),
                                borderRadius: new BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("5:00 PM", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                  Icon(Icons.wb_cloudy, color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8,top: 8,right: 8,bottom: 0),
                                    child: Text("24", style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),),
                                  )
                                ],
                              ),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Container(
                              width: 80,
                              decoration: new BoxDecoration(
                                color: Color(0xFF463B97),
                                borderRadius: new BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("5:00 PM", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                  Icon(Icons.wb_cloudy, color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8,top: 8,right: 8,bottom: 0),
                                    child: Text("24", style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),),
                                  )
                                ],
                              ),
                            )
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left :10.0,top: 0,right: 10.0,bottom: 0),
                  child: Container(
                      height: 200,
                      width: 500,
                      decoration: new BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left:14.0,top:15.0,right: 0.0,bottom: 15.0),
                                child: Text("Tomorrow, 11 Dec",style: TextStyle(fontSize: 18,color: Color(0xFF696969)),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:65.0,top: 15.0,right: 60.0,bottom: 15.0),
                                child: Icon(Icons.cloud_queue,size: 30,color: Color(0xFF696969)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,top: 15.0,right: 8.0,bottom: 15.0),
                                child: Text("26/18",style: TextStyle(fontSize: 18,color: Color(0xFF696969))),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left:14.0,right: 0.0,bottom: 15.0),
                                child: Text("Thu, 12 Dec",style: TextStyle(fontSize: 18,color: Color(0xFF696969)),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0,left: 50),
                                child: Icon(Icons.cloud_queue,size: 30,color: Color(0xFF696969)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 8.0,bottom: 15.0),
                                child: Text("26/18",style: TextStyle(fontSize: 18,color: Color(0xFF696969))),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left:14.0,right: 0.0,bottom: 15.0),
                                child: Text("Fri, 12 Dec",style: TextStyle(fontSize: 18,color: Color(0xFF696969)),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0,left: 60),
                                child: Icon(Icons.cloud_queue,size: 30,color: Color(0xFF696969)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 8.0,bottom: 15.0),
                                child: Text("26/18",style: TextStyle(fontSize: 18,color: Color(0xFF696969))),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left:14.0,right: 0.0,bottom: 15.0),
                                child: Text("Sat, 12 Dec",style: TextStyle(fontSize: 18,color: Color(0xFF696969)),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0,left: 50),
                                child: Icon(Icons.cloud_queue,size: 30,color: Color(0xFF696969)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 8.0,bottom: 15.0),
                                child: Text("26/18",style: TextStyle(fontSize: 18,color: Color(0xFF696969))),
                              )
                            ],
                          ),
                        ],
                      )
                  ),
                ),
                Center(
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.fiber_manual_record, size: 20,),
                            Icon(Icons.panorama_fish_eye, size: 15,),
                          ],
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
