import 'package:TouristGuideApp/loading/Loading.dart';
import 'package:TouristGuideApp/pages/detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Radar extends StatefulWidget {
  final double lat;
  final double lon;

  const Radar({Key key, this.lat, this.lon}) : super(key: key);
  @override
  _RadarState createState() => _RadarState(lat, lon);
}

class _RadarState extends State<Radar> {
  Map mapResponse;
  List listResponse;
  final double lat;
  final double lon;
  bool loading = true;
  _RadarState(this.lat, this.lon);

  Future getBeaches() async {
    String url =
        'https://api.foursquare.com/v2/venues/search?client_id=1YVDDPKVU2GWBJ4AXO1N2Z0NDVLM5XSYEJGIDGVJ5VLIXQZ3&client_secret=SBTXG4HKMKSVSV1PE0JMSH2RYYZV4GBKHXSD4LGUV14IY3HP&v=20180323&ll=23,71&radius=$values&categoryId=4d4b7104d754a06370d81259';

    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      setState(() {
        //  mapResponse = json.decode(response.data);
        //  listResponse = mapResponse['venues'];
        mapResponse = response.data['response'];
        listResponse = mapResponse['venues'];
        loading = false;
      });
      print(listResponse);
    } else {
      throw Exception('Failed');
    }
  }

  ScrollController _scrollController = new ScrollController();

  double values = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Radar'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text('Search places in range'),
              Slider(
                activeColor: Colors.amber,
                inactiveColor: Colors.amber[100],
                value: values,
                min: 0,
                max: 100000,
                divisions: 50,
                label: values.round().toString(),
                onChanged: (value) async {
                  setState(() {
                    this.values = value;
                    loading = true;
                  });
                  await getBeaches();
                },
              ),
              Text((values / 1000).round().toString() + "km"),
              Divider(
                color: Colors.amber,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: loading
                    ? Container(
                        child: SpinKitRing(
                          size: 40,
                          color: Colors.amber,
                        ),
                      )
                    : listResponse.isEmpty
                        ? Text('DATA NOT FOUND')
                        : Column(
                            children: [
                              ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, right: 5, left: 5),
                                            child: ListTile(
                                              tileColor: Colors.amber[100],

                                              title: Text(
                                                  listResponse[index]['name']),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Detail(
                                                              id: listResponse[
                                                                  index]['id'],
                                                            )));
                                              },
                                              // subtitle: Text(city[index]),
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
                                itemCount: listResponse == null
                                    ? 0
                                    : listResponse.length,
                              ),
                            ],
                          ),
              ),
            ],
          ),
        ));
  }
}
