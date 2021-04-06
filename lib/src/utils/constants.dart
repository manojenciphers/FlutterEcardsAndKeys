import 'package:flutter/material.dart';

class Constants{
  // static Constants of(BuildContext context) => context. dependOnInheritedWidgetOfExactType<Constants>();
  //
  // const Constants({Widget child, Key key}): super(key: key, child: child);

  static const String BASE_URL = 'https://e-cardsandkeys.com';
  static const String LOGIN_URL = '/api/login';
  static const String SIGNUP_URL = '/api/register';
  static const String CARD_URL = '/api/card';
  static const String PROFILE_URL = '/api/profile';

  static const String EMAIL_KEY = 'email';
  static const String USERNAME_KEY = 'username';
  static const String AUTH_TOKEN_KEY = 'auth_token';

  // @override
  // bool updateShouldNotify(Constants oldWidget) => false;
}