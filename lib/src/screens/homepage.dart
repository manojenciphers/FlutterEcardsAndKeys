import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecards/src/models/AddCardResponse.dart';
import 'package:flutter_ecards/src/models/AllCardsResponse.dart';
import 'package:flutter_ecards/src/network/apiclient.dart';
import 'package:flutter_ecards/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

import 'login.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final cardNumberController = TextEditingController();
  final cardNameController = TextEditingController();
  final cardExpiryController = TextEditingController();
  final cardCVVController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    cardNameController.dispose();
    cardExpiryController.dispose();
    cardCVVController.dispose();
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text('Card Details', style: TextStyle(fontSize: 20.0)),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 250,
                  child: TextField(
                    controller: cardNumberController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(18),
                    ],
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
                        hintText: 'Enter Card Number'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  width: 250,
                  child: TextField(
                    controller: cardNameController,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
                        hintText: 'Name On Card'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 250,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 150,
                        child: TextField(
                          controller: cardExpiryController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                          ],
                          onChanged: (value) => onExpiryTextChanged(value),
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black)),
                              hintText: 'MM/YY'),
                        ),
                      ),
                      Container(
                        width: 90,
                        child: TextField(
                          controller: cardCVVController,
                          keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                            ],
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black)),
                              hintText: 'CVV'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 250,
                  child: RaisedButton(
                    onPressed: () => addCard(context),
                    color: Colors.teal,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text('Add Card', style: TextStyle(fontSize: 20.0)),
                  ),
                ),
                Container(
                  width: 250,
                  child: RaisedButton(
                    onPressed: () => showAllCards(context),
                    color: Colors.teal,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text('All Cards', style: TextStyle(fontSize: 20.0)),
                  ),
                ),
                Container(
                  width: 250,
                  child: RaisedButton(
                    onPressed: () => showProfile(context),
                    color: Colors.teal,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text('Profile', style: TextStyle(fontSize: 20.0)),
                  ),
                ),
                Container(
                  width: 250,
                  child: RaisedButton(
                    onPressed: () => logout(context),
                    color: Colors.teal,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text('Logout', style: TextStyle(fontSize: 20.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addCard(BuildContext context) async{
    String cardNumber = cardNumberController.text.toString();
    String cardName = cardNameController.text.toString();
    String cardExpiry = cardExpiryController.text.toString();
    String cardCVV = cardCVVController.text.toString();
    String url = Constants.BASE_URL + Constants.CARD_URL;
    Map map = {
      "card_number" : cardNumber ,
      "card_name" : cardName,
      "card_expiration" : cardExpiry,
      "card_cvv" : cardCVV,
    };
    String addCardRequest = await ApiClient.makePostRequest(context, url, map, true);
    AddCardResponse addCardResponse = AddCardResponse.fromJson(jsonDecode(addCardRequest));
    print("addCardRequestaddCardRequest" + addCardRequest);
    if(addCardResponse.message == 'Token is invalid'){
      Toast.show("Session Timeout", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      logout(context);
    }else{
      Toast.show("Card added successfully", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      cardNumberController.text = "";
      cardNameController.text = "";
      cardExpiryController.text = "";
      cardCVVController.text = "";
    }
  }

  showAllCards(BuildContext context) async{
    String url = Constants.BASE_URL + Constants.CARD_URL;
    String allCardsRequest = await ApiClient.makeGetRequest(context, url, true);
    Toast.show("showAllCards" + allCardsRequest, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    AllCardsResponse allCardsResponse = AllCardsResponse.fromJson(jsonDecode(allCardsRequest));
    if(allCardsResponse.message == 'Token is invalid'){
      Toast.show("Session Timeout", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      logout(context);
    }
  }

  showProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile()),
    );
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

  onExpiryTextChanged(String value) {
    // Toast.show("Login successfully" + value, context,
    //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    value = value.replaceAll(RegExp(r"\D"), "");
    switch (value.length) {
      case 1:
        // cardExpiryController.text = "${value}";
        // cardExpiryController.selection = TextSelection.collapsed(offset: 1);
        break;
      case 2:
        // cardExpiryController.text = "$value/";
        // cardExpiryController.selection = TextSelection.collapsed(offset: 2);
        break;
      case 3:
        // cardExpiryController.text =
        // "${value.substring(0, 2)}/${value.substring(2)}";
        // cardExpiryController.selection = TextSelection.collapsed(offset: 4);
        break;
      case 4:
        // cardExpiryController.text =
        // "${value.substring(0, 2)}/${value.substring(2, 4)}";
        // cardExpiryController.selection = TextSelection.collapsed(offset: 5);
        break;
    }
  }
}
