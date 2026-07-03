import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:news_articles/Routes/RouteName.dart';

class SplashServices {
  void isLogin(BuildContext context){
    Timer(Duration(seconds: 3),(){
      Navigator.pushNamedAndRemoveUntil(context, Routename.Home, (route) => false);
    });
  }
}