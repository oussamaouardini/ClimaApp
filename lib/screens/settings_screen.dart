import 'package:clima/screens/applocalization_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/utilities/imports.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int currentPage = 2;

  String currentTitle = "Home";

  Color currentColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var data = EasyLocalizationProvider.of(context).data;
    print(data.locale);
    return EasyLocalizationProvider(
      data: data,
      child: Directionality(
        textDirection: (data.locale.toString() == "en_US")
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          bottomNavigationBar: CubertoBottomBar(
            //  inactiveIconColor: inactiveColor,
            tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
            // By default its CubertoTabStyle.STYLE_NORMAL
            selectedTab: currentPage,
            // By default its 0, Current page which is fetched when a tab is clickd, should be set here so as the change the tabs, and the same can be done if willing to programmatically change the tab.
            // drawer: CubertoDrawer.NO_DRAWER, // By default its NO_DRAWER (Availble START_DRAWER and END_DRAWER as per where you want to how the drawer icon in Cuberto Bottom bar)
            tabs: [
              TabData(
                iconData: Icons.home,
                title: AppLocalizations.of(context).tr("home"),
                tabColor: Color(0xFF607D8B),
              ),
              TabData(
                iconData: Icons.location_on,
                title: AppLocalizations.of(context).tr("localization"),
                tabColor: Color(0xFF607D8B),
              ),
              TabData(
                iconData: Icons.settings,
                title: AppLocalizations.of(context).tr('settings'),
                tabColor: Color(0xFF607D8B),
              ),
            ],
            onTabChangedListener: (position, title, color) async {
              Location location = Location();
              await location.getCurrentLocation();
              setState(() {
                currentPage = position;
                currentTitle = title;
                currentColor = color;

                switch (currentPage) {
                  case 0:
                    Navigator.of(context).pop();
                    break;
                  case 1: case 1: Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AppLocalization(latitude: location.latitude,longitude: location.longitude,)));
                    break;
                  case 2:
                    break;
                  default:
                    break;
                }
              });
            },
          ),
          appBar: AppBar(
            backgroundColor: Color(0xFFb0bec5),
            title: Text(
              AppLocalizations.of(context).tr('settings'),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context).tr('settings'),
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    //Text(
//                      "settings",
//                      style: TextStyle(
//                          fontSize: 18.0, fontWeight: FontWeight.bold),
//                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: new Text(AppLocalizations.of(context)
                                        .tr('change_language')),
                                    content: Container(
                                      height: 120.0,
                                      child: Column(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              data.changeLocale(
                                                  Locale('en', 'US'));
                                            },
                                            child: ListTile(
                                              title: Text("English"),
                                              trailing: Image.asset(
                                                  "images/us_flag.png"),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              data.changeLocale(
                                                  Locale('ar', 'MA'));
                                            },
                                            child: ListTile(
                                              title: Text("العربية"),
                                              trailing: Image.asset(
                                                  "images/ma_flag.png"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: Text(AppLocalizations.of(context)
                                            .tr('close')),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              title: new Text(AppLocalizations.of(context)
                                  .tr('change_language')),
                              trailing: Image.asset(AppLocalizations.of(context)
                                  .tr('language_flag')),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
EasyLocalizationProvider(
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
      ),
    );
* */
