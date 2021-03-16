import 'package:flutter/material.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Weather'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ));
  }
}
