import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ecards/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ApiClient {
  // static ApiClient of(BuildContext context) => context. dependOnInheritedWidgetOfExactType<ApiClient>();
  //
  // const ApiClient({Widget child, Key key}): super(key: key, child: child);

  @override
  bool updateShouldNotify(ApiClient oldWidget) => false;

  static Future<String> makePostRequest(
      BuildContext context, String url, Map map, bool addToken) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.add('content-type', 'application/json');
    if (addToken) {
      final prefs = await SharedPreferences.getInstance();
      final authToken =
          prefs.getString(Constants.AUTH_TOKEN_KEY ?? "");
      request.headers.add('Authorization', authToken);
    }
    print("updateProfileRequest1" + request.headers.toString());
    request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    if (response.statusCode != 200) {
      Toast.show("Something went wrong", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return "";
    }
    return reply;
  }

  static Future<String> makeGetRequest(
      BuildContext context, String url, bool addToken) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.add('content-type', 'application/json');
    if (addToken) {
      final prefs = await SharedPreferences.getInstance();
      final authToken =
          prefs.getString(Constants.AUTH_TOKEN_KEY ?? "");
      request.headers.add('Authorization', authToken);
    }
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    if (response.statusCode != 200) {
      Toast.show("Something went wrong", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return "";
    }
    return reply;
  }

  static Future<String> makeGetRequest1(String url, bool addToken) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.add('content-type', 'application/json');
    if (addToken) {
      final prefs = await SharedPreferences.getInstance();
      final authToken =
      prefs.getString(Constants.AUTH_TOKEN_KEY);
      request.headers.add('Authorization', authToken);
    }
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    if (response.statusCode != 200) {
      // Toast.show("Something went wrong", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return "";
    }
    return reply;
  }
}
