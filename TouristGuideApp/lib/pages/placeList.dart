import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Placelist extends StatefulWidget {
  @override
  _PlacelistState createState() => _PlacelistState();
}

class _PlacelistState extends State<Placelist> {
  @override
  List pl;
  Widget build(BuildContext context) {
    final places = Provider.of<QuerySnapshot>(context);
    for (var doc in places.documents) {
      pl = doc.data['list'];
    }
    print(pl);
    return Container();
  }
}
