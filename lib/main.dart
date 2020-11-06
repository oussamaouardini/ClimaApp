import 'package:clima/screens/weather.dart';
import 'package:clima/utilities/imports.dart';
import 'package:clima/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'model/item.dart';
import 'utilities/size_config.dart';

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
    getAll();
  }

  void getAll() async {
    /// Asking For Permission
    var status = await Permission.location.request();
    if(status.isGranted){
      getLocationData();
    }else{
      noPermission();
    }
    if (status.isUndetermined) {
      var sta = await Permission.location.request();
      if(sta.isGranted){
        getLocationData();
      }else{
        noPermission();
      }
    }

    // You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      noPermission();
    }


  }

  void noPermission(){
      setState(() {
        noPer = true ;
      });
  }
  void getLocationData() async {

    dynamic weatherData = await WeatherModel().getFiveDays();
    int dr = weatherData['list'].length;

    DateTime dt = DateTime.parse(weatherData['list'][0]["dt_txt"]);

    List<dynamic> dates = [];
    List<dynamic> sunData = [];

    for (int i = 0; i < dr; i++) {
      var date =
          dt.difference(DateTime.parse(weatherData['list'][i]["dt_txt"]));

      if (date.inHours % 24 == 0) {

        dates.add(weatherData['list'][i]);
         final response = await WeatherModel().getSunsetSunRise(DateTime.parse(weatherData['list'][i]["dt_txt"]));
        sunData.add(response);
      }
    }
    var weatherDetail = await WeatherModel().getLocationWeather();
      //Navigator.push(context, MaterialPageRoute(builder:(context)=> Wea(locationWeather: dates,currentPage: 0,weatherDetails: weatherDetail,sunSetSunRise: sunData,) ));
    Navigator.push(context, MaterialPageRoute(builder:(context)=> WeatherApp(locationWeather: dates,currentPage: 0,weatherDetails: weatherDetail,sunSetSunRise: sunData,) ));

  }

  bool noPer = false ;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Climate Predictor",style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal*7,
                    fontWeight: FontWeight.bold,
                  )
                ),),
                SizedBox(
                  height: SizeConfig.blockSizeVertical*10,
                ),
                Container(
                  child: noPer == false?SpinKitDoubleBounce(
                    color: Color(0xFF801EFE),
                    size: SizeConfig.blockSizeHorizontal*20,
                  ):Icon(Icons.warning, color: Colors.red, size: 60,),
                ),

                SizedBox(
                  height: SizeConfig.blockSizeVertical*10,
                ),
                 Container(
                   color: Colors.red,
                  child: noPer == true? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Location Permission Is Required",style: GoogleFonts.poppins(
                      fontSize: SizeConfig.blockSizeHorizontal*4.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),
                  ):Container(),
                ),
                noPer == true?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap:()async{
                          var status = await Permission.location.request();

                          if(status.isGranted){
                            setState(() {
                              noPer = false;
                            });
                            getLocationData();

                          }else{
                            noPermission();
                          }
                        },
                        child: Container(
                          color: Colors.green.shade700,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('Click To request Location',style: GoogleFonts.poppins(
                                fontSize: SizeConfig.blockSizeHorizontal*4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ):Container()
              ],
            ),
          ),
      ),
    );
  }
}
