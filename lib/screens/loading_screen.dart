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
    getLocationData() ;
  }

  void getLocationData() async {
   var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder:(context)=> LocationScreen(locationWeather: weatherData,) ));
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
