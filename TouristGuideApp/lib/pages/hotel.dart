import 'package:TouristGuideApp/loading/Loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:TouristGuideApp/services/categoriesId.dart';

class Hotel extends StatefulWidget {
  final double lat;
  final double lon;

  const Hotel({Key key, this.lat, this.lon}) : super(key: key);
  @override
  _HotelState createState() => _HotelState(lat, lon);
}

class _HotelState extends State<Hotel> {
  final double lat;
  final double lon;
  Map mapResponse;

  List listResponse;
  bool loading = true;
  _HotelState(this.lat, this.lon);
  ScrollController _scrollController = new ScrollController();

  Future getHotels() async {
    String url =
        'https://api.foursquare.com/v2/venues/search?client_id=1YVDDPKVU2GWBJ4AXO1N2Z0NDVLM5XSYEJGIDGVJ5VLIXQZ3&client_secret=SBTXG4HKMKSVSV1PE0JMSH2RYYZV4GBKHXSD4LGUV14IY3HP&v=20180323&ll=$lat,$lon&radius=400000&categoryId=$food';
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
    getHotels();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Hotels'),
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
                                      title: Text(listResponse[index]['name']),
                                      // subtitle: Text(city[index]),
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
                ),
    );
  }
}
