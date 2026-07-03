  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_articles/Screens/ArticleDetailScreen/articleDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_articles/Screens/ArticleDetailScreen/articleDetailsScreen.dart';
import 'package:news_articles/Screens/HomeScreen/Home.dart';
import 'package:news_articles/Screens/NewsArticleScreen/NewsArticleScreen.dart';
import 'package:news_articles/Screens/SplashScreen/SplashScreen.dart';
import 'package:news_articles/model/NewsArticleModel.dart';

import 'RouteName.dart';

  class Routes {
    static Route<dynamic> generateRoute(RouteSettings setting){
      switch (setting.name){
        case Routename.SplashScreen:
          return MaterialPageRoute(builder: (context) => SplashScreen(),);
        case Routename.Home:
          return MaterialPageRoute(builder: (context) => Home(),);
        case Routename.NewsArticle:
          final args = setting.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (context) => NewsArticleScreen(category: args['category']),);
        case Routename.ArticleDetails:
          final args = setting.arguments as Map<String, dynamic>;
          return MaterialPageRoute(builder: (context) => Articledetailsscreen(article: args['article']),);
        default:
            return MaterialPageRoute(builder: (context) {
              return Scaffold(body: Text('No Route Found'),);
            },);
      }
    }
  }