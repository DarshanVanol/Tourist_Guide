import 'package:TouristGuideApp/loading/Loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:TouristGuideApp/services/categoriesId.dart';

class Restourant extends StatefulWidget {
  final double lat;
  final double lon;

  const Restourant({Key key, this.lat, this.lon}) : super(key: key);
  @override
  _RestourantState createState() => _RestourantState(lat, lon);
}

class _RestourantState extends State<Restourant> {
  final double lat;
  final double lon;
  Map mapResponse;
  List listResponse;
  bool loading = true;
  ScrollController _scrollController = new ScrollController();

  _RestourantState(this.lat, this.lon);
  Future getRestaurant() async {
    String url =
        'https://api.foursquare.com/v2/venues/search?client_id=1YVDDPKVU2GWBJ4AXO1N2Z0NDVLM5XSYEJGIDGVJ5VLIXQZ3&client_secret=SBTXG4HKMKSVSV1PE0JMSH2RYYZV4GBKHXSD4LGUV14IY3HP&v=20180323&ll=$lat,$lon&categoryId=$accomodation';
    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      setState(() {
        //  mapResponse = json.decode(response.data);
        //  listResponse = mapResponse['venues'];
        mapResponse = response.data['response'];
        listResponse = mapResponse['venues'];
        loading = false;
      });
    } else {
      throw Exception('Failed');
    }
  }

  @override
  void initState() {
    getRestaurant();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: Text('Restourant'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: loading
            ? Loading()
            : mapResponse == null
                ? Container()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        //  Text(mapResponse['response']),

                        ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 5, left: 5),
                                    child: InkWell(
                                      onTap: () {},
                                      child: ListTile(
                                        title:
                                            Text(listResponse[index]['name']),
                                        // subtitle: getloc(index) == ''
                                        //     ? Text('')
                                        //     : Text(getloc(index)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount:
                              listResponse == null ? 0 : listResponse.length,
                        ),
                      ],
                    ),
                  ));
  }

  String getloc(int i) {
    Map loc = listResponse[i]['location'];
    String distance = loc['distance'];
    if (distance == null) {
      return '';
    } else {
      return distance;
    }
  }
}
