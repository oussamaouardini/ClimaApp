import 'package:clima/utilities/imports.dart';


class Location{
  double latitude ;
  double longitude ;

  Future<void> getCurrentLocation() async {
      try{
        Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
        latitude = position.latitude ;
        longitude = position.longitude ;
      }catch(e){
        print(e);
      }
  }


}