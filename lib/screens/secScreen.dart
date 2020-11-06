import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

// ignore: must_be_immutable
class Stats extends StatefulWidget {
  String humidity ;
  String windSpeed ;
  String windDeg ;


  Stats({this.humidity, this.windSpeed,this.windDeg});

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.more_vert),onPressed: (){
                  },),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0.0,bottom: 15.0),
              child: Container(
                height: MediaQuery.of(context).size.height/3 - 25,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10.0,
                    ),]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8,left: 30),
                        child: Text("Humidity",style: TextStyle(fontSize: 20.0),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:8.0,top:10),
                            child: new CircularPercentIndicator(
                              radius: 133.0,
                              lineWidth: 5.0,
                              percent: (double.parse(widget.humidity)/100),
                              center: new Text("${widget.humidity}%"),
                              progressColor: Colors.deepOrange,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Feels like 13",style:TextStyle(fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("UV index 0 Low",style:TextStyle(fontSize: 16)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,bottom: 15,top: 5),
              child: Container(
                height: MediaQuery.of(context).size.height/3 - 25,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10.0,
                    ),]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8,left: 30),
                        child: Text("Wind",style: TextStyle(fontSize: 20.0),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:8.0,top:10),
                            child: new Icon(
                              Icons.golf_course,
                              color: Color(0xFF463B97),
                              size: 80.0,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Direction South-east",style:TextStyle(fontSize: 16)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Speed ${widget.windSpeed} - ${double.parse(widget.windDeg)/100} km/h",style:TextStyle(fontSize: 16)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
