import 'package:clima/services/location.dart';
import 'package:clima/utilities/imports.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class AppLocalization extends StatefulWidget {
  dynamic latitude;
  dynamic longitude;
  AppLocalization({this.latitude,this.longitude});

  @override
  _AppLocalizationState createState() => _AppLocalizationState();
}

class _AppLocalizationState extends State<AppLocalization> {

MapController mapController ;
Map<String,LatLng> coords ;
List<Marker> markers ;

@override
  void initState() {
    mapController = new MapController() ;
    coords = new Map<String,LatLng>();
    coords.putIfAbsent("My Location",()=>LatLng(widget.latitude,widget.longitude),);

    markers = new List<Marker>();

    for(int i = 0 ; i < coords.length ;  i++){
      markers.add(
        new Marker(
            width: 80.0,
            height: 80.0,
            point: coords.values.elementAt(i),
            builder: (context)=>Icon(Icons.pin_drop,color: Colors.red,)
        )
      );
    }
    super.initState();
  }

  void _showCoords(int index){
  mapController.move(coords.values.elementAt(index), 10.0);
  }
  List<Widget> _makeButtons(){
    List<Widget> list = new List<Widget>();

    for(int i = 0 ; i < coords.length ;  i++){
      list.add(RaisedButton(onPressed: ()=>_showCoords(i),child: Text(coords.keys.elementAt(i)),));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var data = EasyLocalizationProvider.of(context).data;
    return  EasyLocalizationProvider(
      data: data,
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
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.wb_cloudy,color:Colors.grey ,size: 40.0,),
                ),
              ),
              IconButton(
                onPressed: () async{
                 },
                icon: Icon(Icons.public,color: Color(0xFF801EFE),size: 40.0,),
              ),

            ],
          ),
        ),
        body: SafeArea(
          child: new Container(
              padding: new EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      new Flexible(
                          child: new FlutterMap(
                            mapController:mapController ,
                            options: new MapOptions(
                              center: new LatLng(41.8781, -87.6298),
                              zoom: 12.0,
                            ),
                            layers: [
                              new TileLayerOptions(
                                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c'],
                              ),
                              MarkerLayerOptions(
                                markers: markers
                              )
                            ],
                          )
                      )
                    ],
                  ),
                  Positioned(child:IconButton(icon: Icon(Icons.pin_drop,color: Colors.red,size: 50.0,), onPressed: (){
                    mapController.move(coords.values.elementAt(0), 10.0);
                  }),top: 0,left:0 ,)
                ],
              )
          ),
        ),
      ),
    );
  }


}
