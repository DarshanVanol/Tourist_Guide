import 'package:flutter/material.dart';

class Places extends StatefulWidget {
  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Nearby Places'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    ));
  }
}
