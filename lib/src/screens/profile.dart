import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_ecards/src/models/ProfileInfoResponse.dart';
import 'package:flutter_ecards/src/models/UpdateProfileResponse.dart';
import 'package:flutter_ecards/src/network/apiclient.dart';
import 'package:flutter_ecards/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  Future<ProfileInfoResponse> profileInfoResponse;
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  Future<ProfileInfoResponse> fetchProfile() async {
    String url = Constants.BASE_URL + Constants.PROFILE_URL;
    String profileInfoRequest = await ApiClient.makeGetRequest1(url, true);
    print(profileInfoRequest);
    ProfileInfoResponse profileInfoResponse = ProfileInfoResponse.fromJson(jsonDecode(profileInfoRequest));
    if(profileInfoResponse.message == 'Token is invalid'){
      Toast.show("Session Timeout", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      logout(context);
    }else{
      setState(() {
        emailController.text = profileInfoResponse.email;
        usernameController.text = profileInfoResponse.username;
      });
    }
    return profileInfoResponse;
  }

  logout(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.AUTH_TOKEN_KEY, "");
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  void initState() {
    super.initState();
    profileInfoResponse = fetchProfile();
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
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
              Text('Profile', style: TextStyle(fontSize: 20.0)),
              Row(
                children: [
                  Container(
                      width: 100,
                      child: Text('Email', style: TextStyle(fontSize: 20.0))),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 248,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: 100,
                      child: Text('Username', style: TextStyle(fontSize: 20.0))),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 248,
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 250,
                margin: EdgeInsets.only(left: 100),
                child: RaisedButton(
                  onPressed: () => update(context),
                  color: Colors.teal,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text('Update', style: TextStyle(fontSize: 20.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  update(BuildContext context) async {
    String email = emailController.text.toString();
    String username = usernameController.text.toString();
    String url =
        Constants.BASE_URL + Constants.PROFILE_URL;
    Map map = {"email": email, "username": username};
    String updateProfileRequest =
        await ApiClient.makePostRequest(context, url, map, true);
    print("updateProfileRequest" + updateProfileRequest);
    if (updateProfileRequest.length > 0) {
      UpdateProfileResponse updateProfileResponse =
          UpdateProfileResponse.fromJson(jsonDecode(updateProfileRequest));
      if (updateProfileResponse.success != null &&
          updateProfileResponse.success == "Profile updated") {
        Toast.show("Update Profile successfully. Please login again" + updateProfileRequest, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        Navigator.of(context).pushNamedAndRemoveUntil('/screens/login', (Route<dynamic> route) => false);
      }else{
        Toast.show("Error in profile updation" + updateProfileRequest, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }
  }
}
