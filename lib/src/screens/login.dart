import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecards/src/models/LoginResponse.dart';
import 'package:flutter_ecards/src/network/apiclient.dart';
import 'package:flutter_ecards/src/screens/homepage.dart';
import 'package:flutter_ecards/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
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
              Text('Login', style: TextStyle(fontSize: 20.0)),
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
                  onPressed: () => login(context),
                  color: Colors.teal,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text('Login', style: TextStyle(fontSize: 20.0)),
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
            ],
          ),
        ),
      ),
    );
  }

  login(BuildContext context) async{
    String email = emailController.text.toString();
    String password = passwordController.text.toString();
    String url = Constants.BASE_URL + Constants.LOGIN_URL;
    Map map = {
      "email" : email ,
      "password" : password
    };
    String loginGetRequest =
        await ApiClient.makePostRequest(context, url, map, false);
    print("loginlogin" + loginGetRequest);
    if(loginGetRequest.length > 0){
      LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(loginGetRequest));
      if(loginResponse.error != null && loginResponse.error.isNotEmpty){
        Toast.show("" + loginResponse.error, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }else{
        Toast.show("Login successfully", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(Constants.USERNAME_KEY, loginResponse.username);
        prefs.setString(Constants.EMAIL_KEY, email);
        prefs.setString(Constants.AUTH_TOKEN_KEY, loginResponse.token);
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    }
  }

  signup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  }
}
