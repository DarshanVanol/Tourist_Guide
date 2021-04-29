import 'package:TouristGuideApp/pages/detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final double lat;
  final double lon;
  final String str;

  const Search({Key key, this.lat, this.lon, this.str}) : super(key: key);
  @override
  _SearchState createState() => _SearchState(lat, lon, str);
}

class _SearchState extends State<Search> {
  final double lat;
  final double lon;
  final String string;

  Map mapResponse;
  List listResponse;
  bool loading = true;

  _SearchState(this.lat, this.lon, this.string);
  Future getBeaches(String str) async {
    String url =
        'https://api.foursquare.com/v2/venues/search?client_id=1YVDDPKVU2GWBJ4AXO1N2Z0NDVLM5XSYEJGIDGVJ5VLIXQZ3&client_secret=SBTXG4HKMKSVSV1PE0JMSH2RYYZV4GBKHXSD4LGUV14IY3HP&v=20180323&ll=$lat,$lon&radius=400000&query=$str';

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
      loading = false;
      throw Exception('failed');
    }
  }

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getBeaches(string);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            mapResponse == null
                ? Container(
                    child: Text(
                      'Found Nothing',
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
          ],
        ),
      ),
    );
  }
}
