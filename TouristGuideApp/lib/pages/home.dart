import 'dart:ui';

import 'package:TouristGuideApp/CategoriesList/BeachesList.dart';
import 'package:TouristGuideApp/CategoriesList/hillstation.dart';
import 'package:TouristGuideApp/CategoriesList/historic.dart';
import 'package:TouristGuideApp/CategoriesList/honeymoon.dart';
import 'package:TouristGuideApp/CategoriesList/natural.dart';
import 'package:TouristGuideApp/CategoriesList/religious.dart';
import 'package:TouristGuideApp/Model/User.dart';
import 'package:TouristGuideApp/pages/Search.dart';
import 'package:TouristGuideApp/pages/detail.dart';
import 'package:TouristGuideApp/pages/radar.dart';
import 'package:TouristGuideApp/pages/whishlist.dart';
import 'package:TouristGuideApp/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:TouristGuideApp/services/auth.dart';
import 'package:TouristGuideApp/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    getCurrentLocation();

    getUserDetails();

    // TODO: implement initState

    super.initState();
  }

  String text = 'Fetching..';
  double lat;
  double lon;
  String userName = '';
  String userEmail = '';
  String search;

  Map mapResponse;
  List listResponse;
  ScrollController _scrollController = new ScrollController();

  Future getNearbyPlaces() async {
    String url =
        'https://api.foursquare.com/v2/venues/search?client_id=1YVDDPKVU2GWBJ4AXO1N2Z0NDVLM5XSYEJGIDGVJ5VLIXQZ3&client_secret=SBTXG4HKMKSVSV1PE0JMSH2RYYZV4GBKHXSD4LGUV14IY3HP&v=20180323&ll=$lat,$lon&radius=400000&limit=5&categoryId=4d4b7104d754a06370d81259';

    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = response.data['response'];
        listResponse = mapResponse['venues'];
      });
    } else {
      throw Exception('Failed');
    }
  }

  getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      text = address.first.locality;
      lat = position.latitude;
      lon = position.longitude;
    });

    getNearbyPlaces();
  }

  AuthService _auth = AuthService();

  getUserDetails() async {
    FirebaseUser result = await _auth.getCurrentUser();
    setState(() {
      userEmail = result.email;
      userName = userEmail.substring(0, 1).toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().places,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle),
                Text(
                  'Radar',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Radar()));
            },
            backgroundColor: Colors.amber,
          ),
          extendBodyBehindAppBar: true,
          drawer: Drawer(
            child: Column(
              children: [
                new UserAccountsDrawerHeader(
                  accountEmail: Text(userEmail),
                  accountName: Text(''),
                  currentAccountPicture: new CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.amber,
                    child: Text(
                      userName,
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                ListTile(
                    title: Text('Whishlists'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Whishlist()));
                    }),
                ElevatedButton(
                  child: Text('Sign Out'),
                  onPressed: () async {
                    await _auth.SignOut();
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Home'),
              actions: [
                RaisedButton.icon(
                  icon: Icon(
                    Icons.place,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await getCurrentLocation();
                  },
                  color: Colors.transparent,
                  elevation: 0,
                  label: Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: 450,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/home.jpg'),
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.black26, BlendMode.darken)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 100, 2, 0),
                        child: Text(
                          'Tour Buddy',
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Calibry'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                            child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  search = val;
                                });
                              },
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                letterSpacing: .5,
                              ),
                              cursorHeight: 20,
                              autofocus: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      if (search != null && search != '') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Search(
                                                    lat: lat,
                                                    lon: lon,
                                                    str: search)));
                                      }
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      size: 32,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  focusColor: Colors.grey[900],
                                  hintText: 'search',
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                  )),
                              cursorColor: Colors.black,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(5, 10),
                                  blurRadius: 12,
                                  spreadRadius: -12,
                                )
                              ]),
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                  child: Row(
                    children: [
                      Text(
                        'Top Catagories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey[850],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CardView(
                        icn: 'beach',
                        tittle: 'Beaches',
                        obj: BeachesList(
                          lat: lat,
                          lon: lon,
                        ),
                      ),
                      CardView(
                        icn: 'mountains',
                        tittle: 'Hill stations',
                        obj: HillStation(
                          lat: lat,
                          lon: lon,
                        ),
                      ),
                      CardView(
                        icn: 'fort2',
                        tittle: 'Historical',
                        obj: Historic(
                          lat: lat,
                          lon: lon,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CardView(
                        icn: 'forest',
                        tittle: 'Nature',
                        obj: Natural(
                          lat: lat,
                          lon: lon,
                        ),
                      ),
                      CardView(
                        icn: 'honeymoon',
                        tittle: 'Honeymoon',
                        obj: Honeymoon(
                          lat: lat,
                          lon: lon,
                        ),
                      ),
                      CardView(
                        icn: 'temple',
                        tittle: 'Religious',
                        obj: Religious(
                          lat: lat,
                          lon: lon,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                  child: Row(
                    children: [
                      Text(
                        'Nearby Places',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey[850],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 200,
                  width: 300,
                  child: mapResponse == null
                      ? SizedBox(
                          height: 1,
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Detail(
                                                  id: listResponse[index]['id'],
                                                )));
                                  },
                                  title: Text(listResponse[index]['name']),
                                  tileColor: Colors.amber[100],
                                ),
                                Divider()
                              ],
                            );
                          },
                          itemCount:
                              listResponse == null ? 0 : listResponse.length,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardView extends StatelessWidget {
  final String icn;
  final String tittle;

  final Object obj;
  const CardView({
    Key key,
    this.icn,
    this.tittle,
    this.obj,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => obj));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(offset: Offset(5, 10), blurRadius: 10, spreadRadius: -13)
          ],
          color: Colors.white,
        ),
        height: 125,
        width: 100,
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/$icn.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Spacer(),
            Text(
              tittle,
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 15),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
