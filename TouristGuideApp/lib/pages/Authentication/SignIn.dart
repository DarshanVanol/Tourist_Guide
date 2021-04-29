import 'package:TouristGuideApp/loading/Loading.dart';
import 'package:TouristGuideApp/services/auth.dart';

import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  final AuthService _auth = AuthService();
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
                  'Sign In',
                  style: TextStyle(color: Colors.grey[800]),
                ),
                actions: [
                  RaisedButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    elevation: 0,
                    label: Text('Register'),
                    icon: Icon(Icons.person),
                    color: Colors.transparent,
                  )
                ],
              ),
              body: Container(
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 20, 50, 20),
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
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            validator: (val) => val.length < 6
                                ? 'Enter password greater than 6 character'
                                : null,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton(
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.SignInwithEmailandPassword(
                                        email, password);

                                if (result == null) {
                                  setState(() {
                                    error = 'Invalid Email or password!';
                                    loading = false;
                                  });
                                } else {
                                  loading = false;
                                }
                              }
                            },
                            child: Text('SignIn'),
                            color: Colors.amber,
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
