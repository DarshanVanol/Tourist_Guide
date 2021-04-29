import 'package:TouristGuideApp/pages/detail.dart';
import 'package:TouristGuideApp/pages/placeList.dart';
import 'package:TouristGuideApp/services/auth.dart';
import 'package:TouristGuideApp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class Whishlist extends StatefulWidget {
  @override
  _WhishlistState createState() => _WhishlistState();
}

class _WhishlistState extends State<Whishlist> {
  String uid;
  List plc;

  List name;
  int i = 1;

  ScrollController _scrollController = new ScrollController();

  AuthService _auth = AuthService();
  Future getuser() async {
    FirebaseUser user = await _auth.getCurrentUser();
    setState(() {
      uid = user.uid;
    });
    print('uid from get user $uid');
    getList(uid);
  }

  Future getList(String u) async {
    DocumentSnapshot data =
        await Firestore.instance.collection('places').document(u).get();
    setState(() {
      plc = data.data['id'];
      name = data.data['name'];
    });
  }

  @override
  void initState() {
    getuser();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
        value: DatabaseService().places,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Whishlist'),
          ),
          body: Column(
            children: [
              ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Divider();
                    } else {
                      return SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 5, left: 5),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Detail(id: plc[index])));
                                  },
                                  child: ListTile(
                                    title: Text(name[index]),
                                    tileColor: Colors.amber[100],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  itemCount: plc == null ? 0 : plc.length)
            ],
          ),
        ));
  }
}
