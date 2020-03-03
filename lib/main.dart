import 'package:clima/screens/home.dart';
import 'package:clima/screens/scrren.dart';
import 'package:clima/screens/weather.dart';
import 'package:clima/utilities/imports.dart';
import 'package:clima/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'model/item.dart';

List<Item> list = <Item>[
  Item(icon: Icon(Icons.settings), title: "settings"),
  Item(icon: Icon(Icons.wb_sunny), title: "Discover Your weather")
];

void main() => runApp(EasyLocalization(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        // theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: LoadingWeather(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasyLocalizationDelegate(locale: data.locale, path: 'assets'),
        ],
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'MA')],
        locale: data.locale,
      ),
    );
  }
}

class LoadingWeather extends StatefulWidget {
  @override
  _LoadingWeatherState createState() => _LoadingWeatherState();
}

class _LoadingWeatherState extends State<LoadingWeather> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    dynamic weatherData = await WeatherModel().getFiveDays();
    int dr = weatherData['list'].length;

    DateTime dt = DateTime.parse(weatherData['list'][0]["dt_txt"]);

    List<dynamic> dates = [];

    for (int i = 0; i < dr; i++) {
      var date =
          dt.difference(DateTime.parse(weatherData['list'][i]["dt_txt"]));
      if (date.inHours % 24 == 0) {
        dates.add(weatherData['list'][i]);
      }
    }
    var weatherDetail = await WeatherModel().getLocationWeather();
      Navigator.push(context, MaterialPageRoute(builder:(context)=> Weather(locationWeather: dates,currentPage: 0,weatherDetails: weatherDetail,) ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
  //  getLocationData();
    return Scaffold(
      backgroundColor: Color(0xFFb0bec5),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Climate Predictor",style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),),
              SpinKitDoubleBounce(
                color: Colors.white,
                size: SizeConfig.blockSizeHorizontal*20,
              ),
            ],
          ),
        ),
    );
  }
}

/*
*change languge
Column(
          children: <Widget>[
            Text(AppLocalizations.of(context).tr('content')),
            OutlineButton(
              onPressed: () {
                data.changeLocale(Locale('ar', 'MA'));
              },
              child: Text(AppLocalizations.of(context).tr('change to arabic')),
            ),
            OutlineButton(
              onPressed: () {
                data.changeLocale(Locale('en', 'US'));
              },
              child: Text(AppLocalizations.of(context).tr('غير للانجليزية ')),
            )
          ],
        ),
*
*
*/
