import 'package:TouristGuideApp/pages/Authentication/Wrapper.dart';
import 'package:TouristGuideApp/pages/detail.dart';
import 'package:TouristGuideApp/pages/placeList.dart';

import 'package:TouristGuideApp/pages/start.dart';

import 'package:TouristGuideApp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TouristGuideApp/Model/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/wrapper',
        routes: {
          '/wishlist': (context) => Placelist(),
          '/Start': (context) => Start(),

          //   '/': (context) => Loading_screen(),
          //   '/home': (context) => Home(),
          '/detail': (context) => Detail(),
          //   '/weather': (context) => Weather(),
          //   '/hotel': (context) => Hotel(),
          //   '/restourant': (context) => Restourant(),
          //   '/signin': (context) => SignIn(),
          '/wrapper': (context) => Wrapper(),
        },
      ),
    );
  }
}
