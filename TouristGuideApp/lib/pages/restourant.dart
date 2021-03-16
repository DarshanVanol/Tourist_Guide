import 'package:flutter/material.dart';

class Restourant extends StatefulWidget {
  @override
  _RestourantState createState() => _RestourantState();
}

class _RestourantState extends State<Restourant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Restourant'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
