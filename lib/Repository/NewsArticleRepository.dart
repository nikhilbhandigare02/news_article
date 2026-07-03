import 'package:news_articles/NetworkApiServices/NetworkServiceApi.dart';

import '../EndPoints/EndPoint.dart';
import '../EndPoints/baseUrl.dart';
import '../model/NewsArticleModel.dart';

class Newsarticlerepository {
  final _api = Networkserviceapi();

  Future<NewsArticleModel> fetchNewsArticle(String category) async{
    final response = await _api.getApi(Baseurl.baseUrl + Endpoint.getTopHeadlines(category.toLowerCase()));
    return NewsArticleModel.fromJson(response);
  }
}

