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

    DateTime dt = DateTime.parse(weatherData['list'][9]["dt_txt"]);

    List<dynamic> dates = [];

    for (int i = 0; i < dr; i++) {
      var date =
          dt.difference(DateTime.parse(weatherData['list'][i]["dt_txt"]));
      if (date.inHours % 24 == 0) {
        dates.add(weatherData['list'][i]);
      }
    }
    var weatherDetail = await WeatherModel().getLocationWeather();
    //print(dt.month);
      Navigator.push(context, MaterialPageRoute(builder:(context)=> WeatherApp(locationWeather: dates,currentPage: 0,weatherDetails: weatherDetail,) ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
  //  getLocationData();
    return Scaffold(
        body: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: SizeConfig.blockSizeHorizontal*20,
          ),
        ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).tr('title')),
          ),
          body: GridView.builder(
              itemCount: list.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return item(list[index].icon, list[index].title);
              })
//        body: Center(
//          child: SpinKitDoubleBounce(
//            color: Colors.white,
//            size: SizeConfig.blockSizeHorizontal*20,
//          ),
//        ),
          ),
    );
  }

  Widget item(Icon icon, String title) {
    return Card(
      child: GridTile(
        child: icon,
        footer: Text(title),
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
