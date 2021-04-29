import 'package:TouristGuideApp/pages/Authentication/Authenticate.dart';
import 'package:TouristGuideApp/pages/Authentication/Wrapper.dart';
import 'package:TouristGuideApp/pages/home.dart';
import 'package:TouristGuideApp/services/auth.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  AuthService _auth = new AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          RaisedButton(
            onPressed: () {},
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.white54),
            ),
            color: Colors.transparent,
            elevation: 0,
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/start.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black45, BlendMode.darken))),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 250),
                child: Text(
                  '  Tour\nBuddy',
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white60,
                      fontWeight: FontWeight.w600),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Authenticate()));
                },
                child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.mail),
                        Text(
                          'Continue with mail',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
