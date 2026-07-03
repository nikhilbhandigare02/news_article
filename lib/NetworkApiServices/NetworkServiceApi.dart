import 'dart:convert';

import 'package:news_articles/NetworkApiServices/baseApiServices.dart';
import 'package:http/http.dart' as http;

class Networkserviceapi  implements Baseapiservices{
  @override
  Future<dynamic> getApi(String url) async{
    try{
      final response = await http.get(Uri.parse(url));
      return _returnResponse(response);

    }catch(e){
      throw "$e";
    }
  }

  dynamic _returnResponse(http.Response response){
    switch (response.statusCode) {

      case 200:
      case 201:
        return jsonDecode(response.body);

      case 400:
        throw Exception("Bad Request: ${response.body}");

      case 401:
        throw Exception("Unauthorized: ${response.body}");

      case 403:
        throw Exception("Forbidden: ${response.body}");

      case 404:
        throw Exception("Not Found: ${response.body}");

      case 500:
        throw Exception("Server Error: ${response.body}");

      default:
        throw Exception(
          "Unexpected Error (${response.statusCode}): ${response.body}",
        );
    }
  }
}