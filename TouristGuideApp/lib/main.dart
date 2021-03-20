// import 'package:TouristGuideApp/pages/Authentication/SignIn.dart';
// import 'package:TouristGuideApp/pages/Authentication/Wrapper.dart';
// import 'package:TouristGuideApp/pages/weather.dart';
import 'package:TouristGuideApp/pages/Authentication/Wrapper.dart';
import 'package:TouristGuideApp/services/auth.dart';
import 'package:flutter/material.dart';
// import 'package:TouristGuideApp/pages/home.dart';
// import 'package:TouristGuideApp/pages/detail.dart';
// import 'package:TouristGuideApp/pages/Loading_screen.dart';
// ignore: unused_import
import 'package:TouristGuideApp/pages/nearby_place.dart';
import 'package:provider/provider.dart';
// import 'package:TouristGuideApp/pages/restourant.dart';
// import 'package:TouristGuideApp/pages/hotel.dart';

import 'package:TouristGuideApp/Model/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),

        // routes: {
        //   '/': (context) => Loading_screen(),
        //   '/home': (context) => Home(),
        //   '/detail': (context) => Detail(),
        //   '/weather': (context) => Weather(),
        //   '/hotel': (context) => Hotel(),
        //   '/restourant': (context) => Restourant(),
        //   '/signin': (context) => SignIn(),
        //   '/wrapper': (context) => Wrapper(),
        // },
      ),
    );
  }
}
