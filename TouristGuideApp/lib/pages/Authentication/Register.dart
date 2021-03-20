import 'package:TouristGuideApp/loading/Loading.dart';
import 'package:TouristGuideApp/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;
  AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.amber[100],
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.amber[600],
                title: Text(
                  'Register',
                  style: TextStyle(color: Colors.grey[800]),
                ),
                actions: [
                  RaisedButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    elevation: 0,
                    label: Text('Sign In'),
                    icon: Icon(Icons.person),
                    color: Colors.transparent,
                  )
                ],
              ),
              body: Container(
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                            ),
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            validator: (val) =>
                                val.isEmpty ? 'Please provide email' : null,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                            validator: (val) => val.length < 6
                                ? 'Enter password greater than 6 character'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton(
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.registerWithEmailandPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply VALID email';
                                    loading = false;
                                  });
                                }
                              } else {}
                            },
                            child: Text('Register'),
                            color: Colors.amber,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
