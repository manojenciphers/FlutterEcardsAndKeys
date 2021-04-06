import 'package:flutter/material.dart';
import 'package:flutter_ecards/src/DeepLinkBloc.dart';
import 'package:flutter_ecards/src/DeeplinkWidget.dart';
import 'package:flutter_ecards/src/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'src/screens/login.dart';
import 'src/utils/constants.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = DeepLinkBloc();

    return MaterialApp(
        title: 'Flutter and Deep Linsk PoC',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              title: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.blue,
                fontSize: 25.0,
              ),
            )),
        home: Scaffold(
            body: Provider<DeepLinkBloc>(
                create: (context) => _bloc,
                dispose: (context, bloc) => bloc.dispose(),
                child: DeeplinkWidget())));
  }
}

// void main() => runApp(Constants(
//         child: MaterialApp(
//       home: Home(),
//     )));

// class Home extends StatefulWidget {
//   @override
//   HomeState createState() => HomeState();
// }

// class HomeState extends State<Home> {
//   final passwordController = TextEditingController();
//
//   @override
//   void dispose() {
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   checkPassword(BuildContext context) async {
//     String result = passwordController.text.toString();
//     if (result == '1') {
//       final prefs = await SharedPreferences.getInstance();
//       final authToken =
//           prefs.getString(Constants.of(context).AUTH_TOKEN_KEY ?? "");
//       Navigator.of(context).pop();
//       if (authToken != null && authToken.isNotEmpty) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HomePage()),
//         );
//       } else {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => Login()),
//         );
//       }
//     } else {
//       Toast.show("Password is not correct", context,
//           duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ECardsAndKeys'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Center(
//           child: Column(
//             children: [
//               Text('Enter Password', style: TextStyle(fontSize: 20.0)),
//               Container(
//                 margin: EdgeInsets.all(30),
//                 width: 250,
//                 child: TextField(
//                   controller: passwordController,
//                   decoration: InputDecoration(
//                       border: new OutlineInputBorder(
//                           borderSide: new BorderSide(color: Colors.black)),
//                       hintText: 'Enter password'),
//                 ),
//               ),
//               Container(
//                 width: 250,
//                 child: RaisedButton(
//                   onPressed: () => checkPassword(context),
//                   color: Colors.teal,
//                   textColor: Colors.white,
//                   padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//                   child: Text('Enter App', style: TextStyle(fontSize: 20.0)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
