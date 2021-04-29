import 'package:TouristGuideApp/loading/Loading.dart';
import 'package:TouristGuideApp/pages/detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:TouristGuideApp/services/categoriesId.dart';

class Honeymoon extends StatefulWidget {
  final double lat;
  final double lon;

  const Honeymoon({Key key, this.lat, this.lon}) : super(key: key);
  @override
  _HoneymoonState createState() => _HoneymoonState(lat, lon);
}

class _HoneymoonState extends State<Honeymoon> {
  final double lat;
  final double lon;
  Map mapResponse;
  List listResponse;
  bool loading = true;

  _HoneymoonState(this.lat, this.lon);
  Future getBeaches(String beach) async {
    String ll = '23.2965088,71.8098794';
    String url =
        'https://api.foursquare.com/v2/venues/search?client_id=1YVDDPKVU2GWBJ4AXO1N2Z0NDVLM5XSYEJGIDGVJ5VLIXQZ3&client_secret=SBTXG4HKMKSVSV1PE0JMSH2RYYZV4GBKHXSD4LGUV14IY3HP&v=20180323&ll=$ll&radius=400000&categoryId=$honeymoon';

    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      setState(() {
        //  mapResponse = json.decode(response.data);
        //  listResponse = mapResponse['venues'];
        mapResponse = response.data['response'];
        listResponse = mapResponse['venues'];
        loading = false;
      });
    }
  }

  @override
  void initState() {
    getBeaches('a');
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Honeymoon points'),
        backgroundColor: Colors.amber,
      ),
      body: loading
          ? Loading()
          : mapResponse == null
              ? Container(
                  child: Text(
                    'Something went Wrong',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      //  Text(mapResponse['response']),
                      ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
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
                                                builder: (context) => Detail(
                                                      id: listResponse[index]
                                                          ['id'],
                                                    )));
                                      },
                                      child: ListTile(
                                        title:
                                            Text(listResponse[index]['name']),
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
                        },
                        itemCount:
                            listResponse == null ? 0 : listResponse.length,
                      )
                    ],
                  ),
                ),
    );
  }
}
