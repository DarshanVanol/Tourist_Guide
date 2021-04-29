import 'package:TouristGuideApp/Model/User.dart';
import 'package:TouristGuideApp/pages/Authentication/Authenticate.dart';
import 'package:TouristGuideApp/pages/home.dart';
import 'package:TouristGuideApp/pages/start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Start();
    } else {
      return Home();
    }
  }
}
