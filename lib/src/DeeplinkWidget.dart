import 'package:flutter/material.dart';
import 'package:flutter_ecards/src/DeepLinkBloc.dart';
import 'package:flutter_ecards/src/screens/homepage.dart';
import 'package:flutter_ecards/src/screens/login.dart';
import 'package:flutter_ecards/src/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DeeplinkWidget extends StatefulWidget {
  @override
  DeeplinkWidgetState createState() => DeeplinkWidgetState();
}

class DeeplinkWidgetState extends State<DeeplinkWidget> {
  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = Provider.of<DeepLinkBloc>(context);
    return StreamBuilder<String>(
      stream: _bloc.state,
      builder: (context, snapshot) {
        var link = "";
        if (snapshot.data != null && snapshot.data.isNotEmpty) {
          var uri =
              Uri.dataFromString(snapshot.data); //converts string to a uri
          Map<String, String> params =
              uri.queryParameters; // query parameters automatically populated
          link = params['link'];
        }
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('ECardsAndKeys'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  children: [
                    Text('Enter Password', style: TextStyle(fontSize: 20.0)),
                    Container(
                      margin: EdgeInsets.all(30),
                      width: 250,
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.black)),
                            hintText: 'Enter password'),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: RaisedButton(
                        onPressed: () => checkPassword(context),
                        color: Colors.teal,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child:
                            Text('Enter App', style: TextStyle(fontSize: 20.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: WebView(
                        initialUrl: link,
                      ))));
        }
      },
    );
  }

  checkPassword(BuildContext context) async {
    String result = passwordController.text.toString();
    if (result == '1') {
      final prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString(Constants.AUTH_TOKEN_KEY);
      Navigator.of(context).pop();
      if (authToken != null && authToken.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    } else {
      Toast.show("Password is not correct", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }
}
