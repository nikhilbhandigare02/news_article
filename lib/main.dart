import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_articles/Routes/RouteName.dart';
import 'package:news_articles/Routes/Routes.dart';
import 'package:news_articles/bloc/NewArticleBloc/news_article_bloc.dart';
import 'package:news_articles/bloc/BookmarkBloc/bookmark_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsArticleBloc()),
        BlocProvider(create: (context) => BookmarkBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News Article',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: Routename.SplashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}


