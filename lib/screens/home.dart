import 'package:clima/screens/secScreen.dart';
import 'package:clima/utilities/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class Weather extends StatefulWidget {

  dynamic locationWeather;
  dynamic weatherDetails;
  int currentPage;
  dynamic sunSetSunRise;

  Weather({this.locationWeather, this.currentPage, this.weatherDetails,this.sunSetSunRise});

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

  String sunset;
  String sunrise;
  String dayLength;

  String cityName;
  WeatherModel weatherModel = WeatherModel();
  String weatherMessage;
  void updateUI(dynamic weather) async {
    if (widget.weatherDetails == null) {
      temperature = 0;
      weatherIcon = 'Eroor ';
      cityName = '';
      weatherMessage = 'Unable to get weather data';
      sunset = "0" ;
      sunrise = "0";
      dayLength = "0";
      return;
    } else {

       sunset = widget.sunSetSunRise[0]['results']['sunset'] ;
       sunrise = widget.sunSetSunRise[0]['results']['sunrise'];
       dayLength = widget.sunSetSunRise[0]['results']['day_length'];

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
  //  updateUI(widget.weatherDetails);
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => Stats(humidity: "${widget.locationWeather[widget.currentPage]['main']['humidity']}",windSpeed: "${widget.locationWeather[widget.currentPage]['wind']['speed']}",windDeg:"${widget.locationWeather[widget.currentPage]['wind']['deg']}" ,) ));
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:15.0),
                      child: IconButton(icon: Icon(Icons.near_me,color: Colors.black,),onPressed: (){
                      },),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:15.0),
                      child: IconButton(icon: Icon(Icons.more_vert,color: Colors.black,),onPressed: (){
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
                  decoration: new BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: new BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
//                      boxShadow: [BoxShadow(
//                        color: Colors.grey.shade200,
//                        blurRadius: 9.0,
//                      ),]
                  ),
                    margin: EdgeInsets.only(top:8.0,right: 8.0,left: 8.0),
                    height: 100,
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("${this.sunrise}"),
                                Text('SunRise'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("${this.sunset}"),
                                Text('SunSet'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("${this.dayLength}"),
                                Text('Day Length'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Container(
                  padding: EdgeInsets.only(top: 0.0),
                    height: 220,
                    width: 500,
                    margin: EdgeInsets.only(right: 8.0,left: 8.0),
                    decoration: new BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0)),
                    ),
                    child: ListView(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        cart(
                            DateTime.parse(
                                widget.locationWeather[0]
                                ["dt_txt"])
                                .day,
                            DateTime.parse(
                                widget.locationWeather[0]
                                ["dt_txt"])
                                .month,days[0],0),

                        cart(
                            DateTime.parse(
                                widget.locationWeather[1]["dt_txt"])
                                .day,
                            DateTime.parse(
                                widget.locationWeather[1]
                                ["dt_txt"])
                                .month,days[1],1),
                        cart(
                            DateTime.parse(
                                widget.locationWeather[2]["dt_txt"])
                                .day,
                            DateTime.parse(
                                widget.locationWeather[2]
                                ["dt_txt"])
                                .month,days[2],2),
                        cart(
                            DateTime.parse(
                                widget.locationWeather[3]["dt_txt"])
                                .day,
                            DateTime.parse(
                                widget.locationWeather[3]
                                ["dt_txt"])
                                .month,days[3],3),
                        cart(
                            DateTime.parse(
                                widget.locationWeather[4]["dt_txt"])
                                .day,
                            DateTime.parse(
                                widget.locationWeather[4]
                                ["dt_txt"])
                                .month,days[4],4),
                      ],
                    )
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
  Widget cart(int day, int month,bool selected,int position) {
    String mon = "";
    switch (month) {
      case 1:
        mon = AppLocalizations.of(context).tr("January");
        break;
      case 2:
        mon = AppLocalizations.of(context).tr("February");
        break;
      case 3:
        mon = AppLocalizations.of(context).tr("March");
        break;
      case 4:
        mon = AppLocalizations.of(context).tr("April");
        break;
      case 5:
        mon = AppLocalizations.of(context).tr("May");
        break;
      case 6:
        mon = AppLocalizations.of(context).tr("June");
        break;
      case 7:
        mon = AppLocalizations.of(context).tr("July");
        break;
      case 8:
        mon = AppLocalizations.of(context).tr("Auguest");
        break;
      case 9:
        mon = AppLocalizations.of(context).tr("September");
        break;
      case 10:
        mon = AppLocalizations.of(context).tr("October");
        break;
      case 11:
        mon = AppLocalizations.of(context).tr("November");
        break;
      case 12:
        mon = AppLocalizations.of(context).tr("December");
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          for(int i = 0 ; i < days.length ; i++ ){
            days[i]=false ;
          }
          setState(() {

            widget.currentPage = position ;
            this.sunset = widget.sunSetSunRise[position]['results']['sunset'] ;
            this.sunrise = widget.sunSetSunRise[position]['results']['sunrise'];
            this.dayLength = widget.sunSetSunRise[position]['results']['day_length'];

            days[position] = true ;
          });
        },
        child:Container(
          decoration: BoxDecoration(
            color: (selected == true)?Colors.grey.shade300:Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:14.0,right: 0.0,bottom: 15.0),
                child: Text("$day / $mon ",style: TextStyle(fontSize: 18,color: Color(0xFF696969)),),
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
        )







        /* Container(
          decoration: BoxDecoration(
            color: (selected == true)?Colors.grey.shade300:Colors.white,
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
        ),*/
      ),
    );
  }
}
