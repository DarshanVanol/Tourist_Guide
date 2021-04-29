import 'package:TouristGuideApp/pages/hotel.dart';
import 'package:TouristGuideApp/pages/restourant.dart';
import 'package:TouristGuideApp/pages/weather.dart';
import 'package:TouristGuideApp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:TouristGuideApp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Detail extends StatefulWidget {
  final String id;

  const Detail({Key key, this.id}) : super(key: key);
  @override
  _DetailState createState() => _DetailState(id);
}

class _DetailState extends State<Detail> {
  AuthService _auth = new AuthService();

  final String id;
  Map reqMap;
  String x = 'x';
  Map reqList;
  String name = '';
  String description = '';
  Map photo;
  List group;
  List items;
  String prefix;
  String suffix;
  var lat;
  var lon;
  int height;
  int width;
  String latitude;
  String longitude;
  bool whishlist = false;
  String imgurl =
      'https://user-images.githubusercontent.com/194400/49531010-48dad180-f8b1-11e8-8d89-1e61320e1d82.png';
  Map loc;
  String city = '';
  _DetailState(this.id);

  getdetails(id) async {
    String url =
        'https://api.foursquare.com/v2/venues/$id?v=20210323&client_id=1YVDDPKVU2GWBJ4AXO1N2Z0NDVLM5XSYEJGIDGVJ5VLIXQZ3&client_secret=SBTXG4HKMKSVSV1PE0JMSH2RYYZV4GBKHXSD4LGUV14IY3HP';
    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      setState(() {
        reqMap = response.data['response'];
        reqList = reqMap['venue'];
        name = reqList['name'];
        description = reqList['description'];
        photo = reqList['photos'];
        group = photo['groups'];
        items = group[0]['items'];
        prefix = items[0]['prefix'];
        suffix = items[0]['suffix'];
        height = items[0]['height'];
        width = items[0]['width'];
        loc = reqList['location'];
        city = loc['city'];
        lat = loc['lat'];
        lon = loc['lng'];
        latitude = '$lat';
        longitude = '$lon';

        imgurl = '$prefix$width$x$height$suffix';
        // reqList = reqMap['venue'];
      });
    }

    print(reqList);
    print(latitude);

    //print(description);
    // print(name);
    // print(description);
  }

  initState() {
    print(id);
    getdetails(id);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[100],
        appBar: AppBar(
          title: Text(name),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imgurl), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Colors.amber[500],
              ),
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Hotel(
                                    lat: lat,
                                    lon: lon,
                                  )));
                    },
                    icon: Icon(
                      Icons.restaurant,
                      color: Colors.grey[800],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Restourant(
                                    lat: lat,
                                    lon: lon,
                                  )));
                    },
                    icon: Icon(
                      Icons.hotel,
                      color: Colors.grey[800],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Weather(
                                    lat: lat,
                                    lon: lon,
                                  )));
                    },
                    icon: Icon(
                      Icons.cloud,
                      color: Colors.grey[800],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.place,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.amber[900],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                  child: Text(
                    'About',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 170),
                  child: Checkbox(
                    value: whishlist,
                    onChanged: (bool value) async {
                      FirebaseUser result = await _auth.getCurrentUser();
                      if (value == true) {
                        DatabaseService(uid: result.uid)
                            .updateUserData(id, name);
                      } else if (value == false) {
                        DatabaseService(uid: result.uid)
                            .deleteUserData(id, name);
                      }

                      setState(() {
                        whishlist = value;
                      });
                    },
                    activeColor: Colors.amber,
                  ),
                ),
                Text('Whishist')
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: description == null
                      ? Text('data not found')
                      : Text(
                          description,
                          style:
                              TextStyle(fontSize: 17, color: Colors.grey[800]),
                        ),
                ),
                decoration: BoxDecoration(
                  color: Colors.amber[400],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ]),
        ),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}
