import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.amber[100],
          appBar: AppBar(
            title: Text('Taj Mahal'),
            elevation: 0,
            backgroundColor: Colors.amber,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Colors.amber[500],
                  ),
                  child: Image(
                    image: AssetImage('assets/taj2.jpg'),
                    fit: BoxFit.cover,
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
                          Navigator.pushNamed(context, '/restourant');
                        },
                        icon: Icon(
                          Icons.restaurant,
                          color: Colors.grey[800],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/hotel');
                        },
                        icon: Icon(
                          Icons.hotel,
                          color: Colors.grey[800],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/weather');
                        },
                        icon: Icon(
                          Icons.cloud,
                          color: Colors.grey[800],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/place');
                        },
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'The Taj Mahal is located on the right bank of the Yamuna River in a vast Mughal garden that encompasses nearly 17 hectares, in the Agra District in Uttar Pradesh. It was built by Mughal Emperor Shah Jahan in memory of his wife Mumtaz Mahal with construction starting in 1632 AD and completed in 1648 AD, with the mosque, the guest house and the main gateway on the south, the outer courtyard and its cloisters were added subsequently and completed in 1653 AD. The existence of several historical and Quaranic inscriptions in Arabic script have facilitated setting the chronology of Taj Mahal. For its construction, masons, stone-cutters, inlayers, carvers, painters, calligraphers, dome builders and other artisans were requisitioned from the whole of the empire and also from the Central Asia and Iran. Ustad-Ahmad Lahori was the main architect of the Taj Mahal. ',
                        style: TextStyle(fontSize: 17, color: Colors.grey[800]),
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
          )),
    );
  }
}
