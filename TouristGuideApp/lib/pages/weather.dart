import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  final double lat;
  final double lon;

  const Weather({Key key, this.lat, this.lon}) : super(key: key);
  _WeatherState createState() => _WeatherState(lat, lon);
}

class _WeatherState extends State<Weather> {
  final double lat;
  final double lon;

  var temp = 0.0;

  String description = '';
  var humidity = 0;
  var pressure = 0.0;
  Map detail;
  Map weather;
  Map condition;
  String img =
      'https://user-images.githubusercontent.com/194400/49531010-48dad180-f8b1-11e8-8d89-1e61320e1d82.png';

  _WeatherState(this.lat, this.lon);
  getWeather() async {
    String url =
        'http://api.weatherapi.com/v1/current.json?key=%20f535bda12ef24e5ab2144904210404&q=$lat,$lon&aqi=no';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      setState(() {
        weather = jsonDecode(res.body);
        // description = weather[0]['description'];
        detail = weather['current'];
        temp = detail['temp_c'];
        condition = detail['condition'];
        description = condition['text'];
        img = condition['icon'];
        pressure = detail['pressure_in'];

        humidity = detail['humidity'];
      });
      print(weather);
    } else {
      throw Exception('failed to load');
    }
  }

  @override
  void initState() {
    getWeather();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                description,
                style: TextStyle(color: Colors.amber, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Temperature',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '$temp \'C',
                style: TextStyle(color: Colors.amber),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Pressure',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '$pressure inHg',
                style: TextStyle(color: Colors.amber),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Humidity',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '$humidity %',
                style: TextStyle(color: Colors.amber),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
