import 'baseUrl.dart';

class Endpoint {
  static String getTopHeadlines(String category) {
    return '/everything?q=$category&apiKey=${Baseurl.apiKey}';
  }
}