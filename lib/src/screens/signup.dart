import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecards/src/models/LoginResponse.dart';
import 'package:flutter_ecards/src/models/SignupResponse.dart';
import 'package:flutter_ecards/src/network/apiclient.dart';
import 'package:flutter_ecards/src/screens/homepage.dart';
import 'package:flutter_ecards/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ECardsAndKeys'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              Text('Sign Up', style: TextStyle(fontSize: 20.0)),
              Container(
                margin: EdgeInsets.all(10),
                width: 250,
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      hintText: 'Enter username'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 250,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      hintText: 'Enter email'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 250,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      hintText: 'Enter password'),
                ),
              ),
              Container(
                width: 250,
                child: RaisedButton(
                  onPressed: () => signup(context),
                  color: Colors.teal,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text('Sign Up', style: TextStyle(fontSize: 20.0)),
                ),
              ),
              Container(
                width: 250,
                child: RaisedButton(
                  onPressed: () => login(context),
                  color: Colors.teal,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text('Login', style: TextStyle(fontSize: 20.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  signup(BuildContext context) async{
    String username = usernameController.text.toString();
    String email = emailController.text.toString();
    String password = passwordController.text.toString();
    String url =
        Constants.BASE_URL + Constants.SIGNUP_URL;
    Map map = {"username": username, "email": email, "password": password};
    String signupRequest =
        await ApiClient.makePostRequest(context, url, map, false);
    print("signupRequestsignupRequest" + signupRequest);
    if (signupRequest.length > 0) {
      SignupResponse signupResponse = SignupResponse.fromJson(jsonDecode(signupRequest));
      if(signupResponse.error != null && signupResponse.error.isNotEmpty){
        Toast.show("" + signupResponse.error, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }else{
        Toast.show("Signup successfully", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    }
  }
}
