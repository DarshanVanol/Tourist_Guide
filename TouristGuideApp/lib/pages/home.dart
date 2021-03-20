import 'package:TouristGuideApp/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              child: Text('Sign Out'),
              onPressed: () async {
                await _auth.SignOut();
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 20, 15),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                  child: TextField(
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                    cursorHeight: 30,
                    autofocus: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            size: 32,
                            color: Colors.grey[900],
                          ),
                        ),
                        focusColor: Colors.grey[900],
                        hintText: 'search',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        )),
                    cursorColor: Colors.black,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  ),
                  CardView(
                    icn: 'mountains',
                    tittle: 'Hill stations',
                  ),
                  CardView(
                    icn: 'fort2',
                    tittle: 'Historical',
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
                  ),
                  CardView(
                    icn: 'honeymoon',
                    tittle: 'Honeymoon',
                  ),
                  CardView(
                    icn: 'temple',
                    tittle: 'Religious',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardView extends StatelessWidget {
  final String icn;
  final String tittle;
  const CardView({
    Key key,
    this.icn,
    this.tittle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
