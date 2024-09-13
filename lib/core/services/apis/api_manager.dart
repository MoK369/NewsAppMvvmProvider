import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news/core/models/news_model.dart';
import 'package:news/core/models/sources_model.dart';

class Endpoints {
  static const String sources = "v2/top-headlines/sources";
  static const String topHeadlines = "v2/top-headlines";
  static const String everyThing = "v2/everything";
}

class ApiManager {
  static const String baseUrl = "newsapi.org";

  static Future<NewsModel?> getNewsByQuery(String query) async {
    Uri url = Uri.https(baseUrl, Endpoints.everyThing, {"q": query});
    http.Response response =
        await http.get(url, headers: {"X-Api-Key": dotenv.env["API_KEY"]!});
    var json = jsonDecode(response.body);
    return NewsModel.fromJson(json);
  }

  static Future<SourcesModel?> getSourcesByCategoryId(String categoryId) async {
    Uri url = Uri.https(baseUrl, Endpoints.sources, {"category": categoryId});

    http.Response response =
        await http.get(url, headers: {"X-Api-Key": dotenv.env["API_KEY"]!});
    var json = jsonDecode(response.body);
    return SourcesModel.fromJson(json);
  }

  static Future<NewsModel?> getTopHeadlinesBySourceId(String sourceId) async {
    Uri url = Uri.https(baseUrl, Endpoints.topHeadlines, {"sources": sourceId});

    http.Response response =
        await http.get(url, headers: {"X-Api-Key": dotenv.env["API_KEY"]!});
    var json = jsonDecode(response.body);
    return NewsModel.fromJson(json);
  }
}
