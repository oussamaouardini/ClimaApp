import 'package:clima/screens/location_screen.dart';
import 'package:clima/utilities/imports.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
      Navigator.push(context, MaterialPageRoute(builder:(context)=> LocationScreen(locationWeather: weatherData,) ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var data = EasyLocalizationProvider.of(context).data;
    //  print(data.locale);
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).tr('title')),
        ),
        body: Column(
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
//        body: Center(
//          child: SpinKitDoubleBounce(
//            color: Colors.white,
//            size: SizeConfig.blockSizeHorizontal*20,
//          ),
//        ),
      ),
    );
  }
}
