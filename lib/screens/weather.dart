import 'package:clima/screens/applocalization_screen.dart';
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
  dynamic sunSetSunRise;

  WeatherApp({this.locationWeather, this.currentPage, this.weatherDetails,this.sunSetSunRise});

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
  String sunset;
  String sunrise;
  String dayLength;
  String solarnon;


  void updateUI(dynamic weather) {
    if (widget.weatherDetails == null) {
      temperature = 0;
      weatherIcon = 'Eroor ';
      cityName = '';
      weatherMessage = 'Unable to get weather data';
      sunset = "0" ;
      sunrise = "0";
      dayLength = "0";
      solarnon = "0";
      return;
    } else {
      sunset = widget.sunSetSunRise[widget.currentPage]['results']['sunset'] ;
      sunrise = widget.sunSetSunRise[widget.currentPage]['results']['sunrise'];
      dayLength = widget.sunSetSunRise[widget.currentPage]['results']['day_length'];
      solarnon = widget.sunSetSunRise[widget.currentPage]['results']['solar_noon'];

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
      child: Stack(
        children: <Widget>[
          WillPopScope(
            onWillPop: () {
              return moveToLastScreen();
            },
            child: Directionality(
              textDirection:  ( data.locale.toString() == "en_US" ) ? TextDirection.ltr : TextDirection.rtl ,
              child: Scaffold(
                bottomNavigationBar: Container(
                  height: SizeConfig.blockSizeVertical*8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only(right:15.0),
                        child: IconButton(
                          onPressed: (){

                          },
                          icon: Icon(Icons.wb_cloudy,color: Color(0xFF801EFE),size: 40.0,),
                        ),
                      ),
                      IconButton(
                        onPressed: () async{
                          Location location = Location();
                          await location.getCurrentLocation();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AppLocalization(latitude: location.latitude,longitude: location.longitude,)));
                        },
                        icon: Icon(Icons.public,color: Colors.grey,size: 40.0,),
                      ),

                    ],
                  ),
                ),
                /*  bottomNavigationBar: CubertoBottomBar(
                    barBackgroundColor: Color(0xFFF6F7F9),
                  //  inactiveIconColor: inactiveColor,
                    tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND, // By default its CubertoTabStyle.STYLE_NORMAL
                    selectedTab: currentPage,
                    inactiveIconColor: Colors.grey,
                    barBorderRadius: BorderRadius.all(Radius.circular(25.0)),
                    // By default its 0, Current page which is fetched when a tab is clickd, should be set here so as the change the tabs, and the same can be done if willing to programmatically change the tab.
                   // drawer: CubertoDrawer.NO_DRAWER, // By default its NO_DRAWER (Availble START_DRAWER and END_DRAWER as per where you want to how the drawer icon in Cuberto Bottom bar)
                    tabs: [
                      TabData(
                        iconData: Icons.home,
                        title: AppLocalizations.of(context).tr("home"),
                        tabColor: Color(0xFF801EFE),
                      ),
                      TabData(
                        iconData: Icons.location_on,
                        title: AppLocalizations.of(context).tr("localization"),
                        tabColor: Color(0xFF801EFE),
                      ),
                      TabData(
                        iconData: Icons.settings,
                        title: AppLocalizations.of(context).tr('settings'),
                        tabColor: Color(0xFF801EFE),
                      ),
                    ],
                    onTabChangedListener: (position, title, color) async {
                      Location location = Location();
                      await location.getCurrentLocation();
                      setState(() {
                        currentPage = position;
                        currentTitle = title;
                        currentColor = color;

                        switch(currentPage){
                          case 0: break ;
                          case 1: Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AppLocalization(latitude: location.latitude,longitude: location.longitude,))); break ;
                          case 2: Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Settings()));break;
                          default:break ;
                        }
                      });
                    },
                  ),*/
                /*  appBar: AppBar(
                    title: appBarTitle,
                    backgroundColor: Color(0xFFF6F7F9),
                    actions: <Widget>[
                      IconButton(
                          icon: actionIcon,
                          onPressed: () {
                            // this.actionIcon = new Icon(Icons.close);
                            setState(() {
                              if (this.actionIcon.icon == Icons.search) {
                                this.actionIcon = new Icon(Icons.close);
                                this.appBarTitle = new TextField(
                                  focusNode: focusNode,
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
                                                      title: Text(AppLocalizations.of(context).tr('sorry')),
                                                      content: new Text(AppLocalizations.of(context).tr('WeCouldFind')+"\"${searchController.text}\""),
                                                      actions: <Widget>[
                                                        // usually buttons at the bottom of the dialog
                                                        new FlatButton(
                                                          child: Text(AppLocalizations.of(context).tr('close')),
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
                                      hintText: AppLocalizations.of(context).tr('search')+"...",
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
                  ),*/
                  backgroundColor: Color(0xFFF6F7F9),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("${widget.weatherDetails['name']}",style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeConfig.safeBlockHorizontal*10),),
                                      IconButton(
                                        icon: Icon(Icons.more_vert),
                                        onPressed: (){

                                        },
                                      )
                                    ],
                                  ),
                                  cart(
                                      DateTime.parse(
                                          widget.locationWeather[0]
                                          ["dt_txt"])
                                          .day,
                                      DateTime.parse(
                                          widget.locationWeather[0]
                                          ["dt_txt"])
                                          .month,days[0],0),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: double.infinity,
                              height: SizeConfig.safeBlockVertical*29,
                              child: PageView(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: SizeConfig.safeBlockVertical*25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFF6F7F9),
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
                                          ],
                                        ),
                                        child: Center(child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(text: '${this.temperature}',style: TextStyle(
                                                      color: Color(0xFF801EFE),
                                                      fontSize: SizeConfig.safeBlockVertical*9,
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                  TextSpan(text: ' °C',style: TextStyle(
                                                      color: Color(0xFF801EFE),
                                                      fontSize: SizeConfig.safeBlockVertical*5,
                                                      fontWeight: FontWeight.w500
                                                  ),),
                                                ],
                                              ),
                                            ),

                                            Text(widget.locationWeather[widget.currentPage]
                                            ['weather']
                                            [0]['main'] +
                                                " : " +
                                                widget.locationWeather[widget
                                                    .currentPage]['weather']
                                                [0]
                                                ['description'],style: TextStyle(
                                              color: Color(0xFF801EFE),
                                              fontSize: SizeConfig.safeBlockVertical*2,
                                            ),),
                                          ],
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.fiber_manual_record,color: Colors.amber,size: 15.0,),
                                            Icon(Icons.fiber_manual_record,color: Colors.grey,size: 10.0,),
                                            Icon(Icons.fiber_manual_record,color: Colors.grey,size: 10.0,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: SizeConfig.safeBlockVertical*25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFF6F7F9),
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
                                          ],
                                        ),
                                        child: Center(child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(text: '${this.temperatureMin-2}',style: TextStyle(
                                                      color: Color(0xFF801EFE),
                                                      fontSize: SizeConfig.safeBlockVertical*9,
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                  TextSpan(text: ' °C',style: TextStyle(
                                                      color: Color(0xFF801EFE),
                                                      fontSize: SizeConfig.safeBlockVertical*5,
                                                      fontWeight: FontWeight.w500
                                                  ),),
                                                ],
                                              ),
                                            ),

                                            Text(AppLocalizations.of(context).tr("mintemp"),style: TextStyle(
                                              color: Color(0xFF801EFE),
                                              fontSize: SizeConfig.safeBlockVertical*2,
                                            ),),
                                          ],
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.fiber_manual_record,color: Colors.grey,size: 10.0,),
                                            Icon(Icons.fiber_manual_record,color: Colors.amber,size: 15.0,),
                                            Icon(Icons.fiber_manual_record,color: Colors.grey,size: 10.0,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: SizeConfig.safeBlockVertical*25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFF6F7F9),
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
                                          ],
                                        ),
                                        child: Center(child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(text: '${this.temperatureMax+2}',style: TextStyle(
                                                      color: Color(0xFF801EFE),
                                                      fontSize: SizeConfig.safeBlockVertical*9,
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                  TextSpan(text: ' °C',style: TextStyle(
                                                      color: Color(0xFF801EFE),
                                                      fontSize: SizeConfig.safeBlockVertical*5,
                                                      fontWeight: FontWeight.w500
                                                  ),),
                                                ],
                                              ),
                                            ),

                                            Text(AppLocalizations.of(context).tr("maxtemp"),style: TextStyle(
                                              color: Color(0xFF801EFE),
                                              fontSize: SizeConfig.safeBlockVertical*2,
                                            ),),
                                          ],
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.fiber_manual_record,color: Colors.grey,size: 10.0,),
                                            Icon(Icons.fiber_manual_record,color: Colors.grey,size: 10.0,),
                                            Icon(Icons.fiber_manual_record,color: Colors.amber,size: 15.0,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      card(
                                          DateTime.parse(
                                              widget.locationWeather[0]
                                              ["dt_txt"])
                                              .day,
                                          DateTime.parse(
                                              widget.locationWeather[0]
                                              ["dt_txt"])
                                              .month,days[0],0),

                                      card(
                                          DateTime.parse(
                                              widget.locationWeather[1]["dt_txt"])
                                              .day,
                                          DateTime.parse(
                                              widget.locationWeather[1]
                                              ["dt_txt"])
                                              .month,days[1],1),
                                      card(
                                          DateTime.parse(
                                              widget.locationWeather[2]["dt_txt"])
                                              .day,
                                          DateTime.parse(
                                              widget.locationWeather[2]
                                              ["dt_txt"])
                                              .month,days[2],2),
                                      card(
                                          DateTime.parse(
                                              widget.locationWeather[3]["dt_txt"])
                                              .day,
                                          DateTime.parse(
                                              widget.locationWeather[3]
                                              ["dt_txt"])
                                              .month,days[3],3),
                                      card(
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
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                Text("Additional Info",style: TextStyle(
                                  color: Color(0xFF4D4D4D),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0
                                ),)
                              ],
                            ),

                            Container(
                              height: SizeConfig.safeBlockVertical*33,
                              child: PageView(
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF6F7F9),
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
                                                Colors.black.withOpacity(.15)),

                                          ],
                                          borderRadius: BorderRadius.all(Radius.circular(10)),

                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(right:15.0),
                                                      child: Container(
                                                        height: 55,
                                                        width: 55,
                                                        decoration: BoxDecoration(

                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(20.0)),
                                                            ),
                                                        child: Icon(
                                                          FontAwesome.leaf,
                                                          color: Color(0xFF801EFE),
                                                          size: 30.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(AppLocalizations.of(context).tr("humidity"),
                                                            style: TextStyle(
                                                                fontFamily: "nunito",
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w600,
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
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:15.0),
                                                        child: Container(
                                                          height: 55,
                                                          width: 55,
                                                          decoration: BoxDecoration(

                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(20.0)),
                                                              ),
                                                          child: Icon(
                                                            FontAwesome.compress,
                                                            color: Color(0xFF801EFE),
                                                            size: 30.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(AppLocalizations.of(context).tr("Pressure"),
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 15.0)),
                                                          Text(
                                                              "${widget.locationWeather[widget.currentPage]['main']['pressure']} Hp",
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black.withOpacity(.5),
                                                                  fontSize: 15.0))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                              ],),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:15.0),
                                                        child: Container(
                                                          height: 55,
                                                          width: 55,
                                                          decoration: BoxDecoration(

                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(20.0)),
                                                              ),
                                                          child: Icon(
                                                            Icons.golf_course,
                                                            color:Color(0xFF801EFE),
                                                            size: 30.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(AppLocalizations.of(context).tr("Wind"),
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 15.0)),
                                                          Text(
                                                              "${widget.locationWeather[widget.currentPage]['wind']['speed']}",
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black.withOpacity(.5),
                                                                  fontSize: 15.0))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:15.0),
                                                        child: Container(
                                                          height: 55,
                                                          width: 55,
                                                          decoration: BoxDecoration(

                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(20.0)),
                                                              ),
                                                          child: Icon(
                                                            Icons.directions_boat,
                                                            color: Color(0xFF801EFE),
                                                            size: 30.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(AppLocalizations.of(context).tr("Sea Level"),
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 15.0)),
                                                          Text(
                                                              "${widget.locationWeather[widget.currentPage]['main']['sea_level']}",
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black.withOpacity(.5),
                                                                  fontSize: 15.0))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(Icons.fiber_manual_record,color: Color(0xFF801EFE),size: 15.0,),
                                                  Icon(Icons.fiber_manual_record,color: Colors.grey,size: 10.0,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                  Container(

                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF6F7F9),
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
                                                Colors.black.withOpacity(.15)),

                                          ],
                                          borderRadius: BorderRadius.all(Radius.circular(10)),

                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:15.0),
                                                        child: Container(
                                                          height: 55,
                                                          width: 55,
                                                          decoration: BoxDecoration(

                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(20.0)),
                                                          ),
                                                          child: Icon(
                                                            FontAwesome.sun_o,
                                                            color: Colors.amber,
                                                            size: 30.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(AppLocalizations.of(context).tr("Sunset"),
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 15.0)),
                                                          Text(
                                                              "${this.sunset}",
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black.withOpacity(.5),
                                                                  fontSize: 15.0))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:15.0),
                                                        child: Container(
                                                          height: 55,
                                                          width: 55,
                                                          decoration: BoxDecoration(

                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(20.0)),
                                                          ),
                                                          child: Icon(
                                                            Icons.brightness_6,
                                                            color: Colors.amber,
                                                            size: 30.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(AppLocalizations.of(context).tr("sunrise"),
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 15.0)),
                                                          Text(
                                                              "${this.sunrise}",
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black.withOpacity(.5),
                                                                  fontSize: 15.0))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:15.0),
                                                        child: Container(
                                                          height: 55,
                                                          width: 55,
                                                          decoration: BoxDecoration(

                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(20.0)),
                                                          ),
                                                          child: Icon(
                                                            Icons.hourglass_empty,
                                                            color:Colors.amber,
                                                            size: 30.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(AppLocalizations.of(context).tr("solarnoon"),
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 15.0)),
                                                          Text(
                                                              "${this.solarnon}",
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black.withOpacity(.5),
                                                                  fontSize: 15.0))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:15.0),
                                                        child: Container(
                                                          height: 55,
                                                          width: 55,
                                                          decoration: BoxDecoration(

                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(20.0)),
                                                          ),
                                                          child: Icon(
                                                            Icons.watch_later,
                                                            color: Colors.amber,
                                                            size: 30.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(AppLocalizations.of(context).tr("daylength"),
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 15.0)),
                                                          Text(
                                                              "${this.dayLength}",
                                                              style: TextStyle(
                                                                  fontFamily: "nunito",
                                                                  color: Colors.black.withOpacity(.5),
                                                                  fontSize: 15.0))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(Icons.fiber_manual_record,color: Colors.grey,size: 10.0,),
                                                  Icon(Icons.fiber_manual_record,color: Colors.amber,size: 15.0,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
    return InkWell(
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
        //  color: (selected == true)?Colors.grey.shade300:Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "$day, ",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0,color: Color(0xFFADADBB)),
            ),
            Text(
              "$mon  2020",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.0,color: Color(0xFFADADBB)),
            ),
          ],
        ),
      ),
    );
  }
  Widget card(int day, int month,bool selected,int position) {
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
    return InkWell(
      onTap: () {
        for(int i = 0 ; i < days.length ; i++ ){
          days[i]=false ;
        }
        setState(() {
          widget.currentPage = position ;

          days[position] = true ;

          sunset = widget.sunSetSunRise[position]['results']['sunset'] ;
          sunrise = widget.sunSetSunRise[position]['results']['sunrise'];
          dayLength = widget.sunSetSunRise[position]['results']['day_length'];
          solarnon = widget.sunSetSunRise[position]['results']['solar_noon'];

        });
      },
      child:Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 8.0),
          child: Container(
            width: 80,
            decoration: new BoxDecoration(
              color: (selected == true)?Color(0xFF801EFE):Color(0xFFF6F7F9),
            //  color: Color(0xFFFF7F7E),
              borderRadius: new BorderRadius.all(Radius.circular(5)),
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
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("$day ", style: TextStyle(fontSize: 16, color: (selected == true)?Colors.white:Colors.grey, fontWeight: FontWeight.bold),),
                ),
                Icon(Icons.wb_cloudy, color: (selected == true)?Colors.white:Colors.grey,),
                Padding(
                  padding: const EdgeInsets.only(left:8,top: 8,right: 8,bottom: 0),
                  child: Text("$mon", style: TextStyle(fontSize: 14, color: (selected == true)?Colors.white:Colors.grey,fontWeight: FontWeight.bold),),
                )
              ],
            ),
          )
      ),

      /*
      * Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: SizeConfig.safeBlockHorizontal*20,
          decoration: BoxDecoration(
              color: (selected == true)?Colors.grey.shade300:Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "$day, ",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0,color: Color(0xFFADADBB)),
              ),
              Text(
                "$mon",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.0,color: Color(0xFFADADBB)),
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}



/*7
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
* */