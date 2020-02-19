import 'package:clima/screens/settings_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:clima/utilities/imports.dart';
class WeatherApp extends StatefulWidget {
  dynamic locationWeather;
  dynamic weatherDetails;
  int currentPage;

  WeatherApp({this.locationWeather, this.currentPage, this.weatherDetails});

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {

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
  @override
  Widget build(BuildContext context) {
    updateUI(widget.weatherDetails);
    SizeConfig().init(context);
    return EasyLocalizationProvider(
      child: Stack(
        children: <Widget>[
          WillPopScope(
            onWillPop: () {
              return moveToLastScreen();
            },
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Scaffold(
                  bottomNavigationBar: CubertoBottomBar(
                  //  inactiveIconColor: inactiveColor,
                    tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND, // By default its CubertoTabStyle.STYLE_NORMAL
                    selectedTab: currentPage, // By default its 0, Current page which is fetched when a tab is clickd, should be set here so as the change the tabs, and the same can be done if willing to programmatically change the tab.
                   // drawer: CubertoDrawer.NO_DRAWER, // By default its NO_DRAWER (Availble START_DRAWER and END_DRAWER as per where you want to how the drawer icon in Cuberto Bottom bar)
                    tabs: [
                      TabData(
                        iconData: Icons.home,
                        title: "Home",
                        tabColor: Color(0xFF607D8B),
                      ),
                      TabData(
                        iconData: Icons.search,
                        title: "Search",
                        tabColor: Color(0xFF607D8B),
                      ),
                      TabData(
                          iconData: Icons.location_on,
                          title: "Alarm",
                        tabColor: Color(0xFF607D8B),
                      ),
                      TabData(
                          iconData: Icons.settings,
                          title: "Settings",
                        tabColor: Color(0xFF607D8B),
                      ),
                    ],
                    onTabChangedListener: (position, title, color) {
                      setState(() {
                        currentPage = position;
                        currentTitle = title;
                        currentColor = color;

                        if(position == 3){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Settings()));
                        }

                      });
                    },
                  ),
                  appBar: AppBar(
                    title: appBarTitle,
                    backgroundColor: Color(0xFFb0bec5),
                    actions: <Widget>[
                      IconButton(
                          icon: actionIcon,
                          onPressed: () {
                            // this.actionIcon = new Icon(Icons.close);
                            setState(() {
                              if (this.actionIcon.icon == Icons.search) {
                                this.actionIcon = new Icon(Icons.close);
                                this.appBarTitle = new TextField(
                                  controller: searchController,
                                  style: new TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: new InputDecoration(
                                      prefixIcon: InkWell(
                                          onTap: () async {
                                            if (searchController.text.isEmpty) {
                                            } else {

                                              setState(() {
                                                loading = true ;
                                              });

                                              dynamic weatherData = await WeatherModel().getFiveDaysByName(searchController.text.toString());
                                              int dr ;
                                              try{
                                                dr = weatherData['list'].length;
                                              }catch(e){
                                                dr = 0 ;
                                              }





                                              List<dynamic> dates = [];



                                              if(dr>0){
                                             DateTime dt = DateTime.parse(weatherData['list'][0]["dt_txt"]);
                                                for (int i = 0; i < dr; i++) {
                                                  var date =
                                                  dt.difference(DateTime.parse(weatherData['list'][i]["dt_txt"]));
                                                  if (date.inHours % 24 == 0) {
                                                    dates.add(weatherData['list'][i]);
                                                  }
                                                }

                                                var weatherDetail = await WeatherModel().getLocationWeatherByName(searchController.text.toString());
                                                setState(() {
                                                  loading = false ;
                                                });
                                                Navigator.push(context, MaterialPageRoute(builder:(context)=> WeatherApp(locationWeather: dates,currentPage: 0,weatherDetails: weatherDetail,) ));

                                              }else{
                                                setState(() {
                                                  loading = false ;
                                                });
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    // return object of type Dialog
                                                    return AlertDialog(
                                                      title: new Text("Soory"),
                                                      content: new Text("We couldn't find  \"${searchController.text}\"  city"),
                                                      actions: <Widget>[
                                                        // usually buttons at the bottom of the dialog
                                                        new FlatButton(
                                                          child: new Text("Close"),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }

                                            }
                                          },
                                          child: new Icon(Icons.search,
                                              color: Colors.white)),
                                      hintText: "Search...",
                                      hintStyle: new TextStyle(color: Colors.white)),
                                );
                              } else {
                                this.actionIcon = new Icon(Icons.search);
                                this.appBarTitle = new Text("Climate Predictor");
                              }
                            });
                          }),
                    ],
                    leading: IconButton(icon: Icon(Icons.near_me),
                      onPressed: () async{

                      setState(() {
                        loading = true ;
                      });
                        dynamic weatherData = await WeatherModel().getFiveDays();
                        int dr = weatherData['list'].length;

                        DateTime dt = DateTime.parse(weatherData['list'][9]["dt_txt"]);

                        List<dynamic> dates = [];

                        for (int i = 0; i < dr; i++) {
                          var date =
                          dt.difference(DateTime.parse(weatherData['list'][i]["dt_txt"]));
                          if (date.inHours % 24 == 0) {
                            dates.add(weatherData['list'][i]);
                          }
                        }
                        if(dates.length>0){
                          var weatherDetail = await WeatherModel().getLocationWeather();
                          setState(() {
                            loading = false ;
                          });
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> WeatherApp(locationWeather: dates,currentPage: 0,weatherDetails: weatherDetail,) ));

                        }else{

                        }

                      },
                    ),
                  ),
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
                                        padding:
                                        const EdgeInsets.only(top: 8.0, left: 8.0),
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "${widget.weatherDetails['name']}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22.0),
                                              ),
                                            ],
                                          ),
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
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Text(
                                                  "weather",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
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
                                                            color: Colors.white
                                                                .withOpacity(.7)),
                                                        BoxShadow(
                                                            blurRadius: 5.0,
                                                            offset: Offset(3, 3),
                                                            color: Colors.black
                                                                .withOpacity(.15))
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                          color: Colors.black
                                                              .withOpacity(.5),
                                                          fontSize: 15.0)),
                                                  Text("  ${this.temperatureMin}°C",
                                                      style: TextStyle(
                                                          fontFamily: "nunito",
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.black
                                                              .withOpacity(.3),
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
                                          Text(
                                              widget.locationWeather[widget.currentPage]
                                              ['weather']
                                              [0]['main'] +
                                                  ":" +
                                                  widget.locationWeather[widget
                                                      .currentPage]['weather']
                                                  [0]
                                                  ['description'],
                                              style: TextStyle(
                                                  fontFamily: "nunito"  ,
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
                                          Text(
                                              "${widget.locationWeather[widget.currentPage]['main']['humidity']}%",
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
                                          Text(
                                              "${widget.locationWeather[widget.currentPage]['main']['pressure']}",
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
                                          Text(
                                              "${widget.locationWeather[widget.currentPage]['wind']['speed']}",
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
                                          Text(
                                              "${widget.locationWeather[widget.currentPage]['main']['sea_level']}",
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
                                    Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                      size: 30.0,
                                    ),
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
                                    Text(
                                        "${widget.locationWeather[widget.currentPage]['main']['temp']}°K -- ${this.temperature}°C  at   ${widget.locationWeather[widget.currentPage]['dt_txt']} ",
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
            ),
          ),
          Container(
            child: (loading == true  )? Positioned(child:SpinKitDoubleBounce(
              color: Colors.blueGrey,
              size: SizeConfig.blockSizeHorizontal*20,
            ),top: SizeConfig.blockSizeVertical*50,left:SizeConfig.blockSizeHorizontal*40 ,):null,
          )
        ],
      ),
    );
  }

  Future<void> moveToLastScreen() {
    return null;
  }

  Widget cart(int day, int month,bool selected,int position) {
    String mon = "";
    switch (month) {
      case 1:
        mon = "January";
        break;
      case 2:
        mon = "February";
        break;
      case 3:
        mon = "March ";
        break;
      case 4:
        mon = "April ";
        break;
      case 5:
        mon = "May";
        break;
      case 6:
        mon = "June";
        break;
      case 7:
        mon = "July";
        break;
      case 8:
        mon = "Auguest";
        break;
      case 9:
        mon = "September";
        break;
      case 10:
        mon = "October";
        break;
      case 11:
        mon = "November";
        break;
      case 12:
        mon = "December";
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

            days[position] = true ;
          });
        },
        child: Container(
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
        ),
      ),
    );
  }
}


