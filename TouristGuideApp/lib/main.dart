import 'package:TouristGuideApp/pages/weather.dart';
import 'package:flutter/material.dart';
import 'package:TouristGuideApp/pages/home.dart';
import 'package:TouristGuideApp/pages/detail.dart';
import 'package:TouristGuideApp/pages/Loading_screen.dart';
import 'package:TouristGuideApp/pages/nearby_place.dart';
import 'package:TouristGuideApp/pages/restourant.dart';
import 'package:TouristGuideApp/pages/hotel.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/': (context) => Loading_screen(),
      '/home': (context) => Home(),
      '/detail': (context) => Detail(),
      '/weather': (context) => Weather(),
      '/hotel': (context) => Hotel(),
      '/restourant': (context) => Restourant(),
      '/place': (context) => Places(),
    },
  ));
}
