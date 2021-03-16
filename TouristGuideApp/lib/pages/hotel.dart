import 'package:flutter/material.dart';

class Hotel extends StatefulWidget {
  @override
  _HotelState createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Hotels'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
