import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news/core/models/news_model.dart';
import 'package:news/core/models/sources_model.dart';
import 'package:news/core/services/apis/api_result.dart';

class Endpoints {
  static const String sources = "v2/top-headlines/sources";
  static const String topHeadlines = "v2/top-headlines";
  static const String everyThing = "v2/everything";
}

class ApiManager {
  static const String baseUrl = "newsapi.org";

  static Future<ApiResult<NewsModel>> getNewsByQuery(String query) async {
    Uri url = Uri.https(baseUrl, Endpoints.everyThing, {"q": query});
    try {
      http.Response response =
          await http.get(url, headers: {"X-Api-Key": dotenv.env["API_KEY"]!});
      var json = jsonDecode(response.body);
      NewsModel newsModel = NewsModel.fromJson(json);
      if (newsModel.status == 'ok') {
        return Success(data: newsModel);
      } else {
        return ServerError(
            code: newsModel.code ?? "",
            message: newsModel.message ?? "Something Went Wrong 🤔");
      }
    } on Exception catch (e) {
      return CodeError(exception: e);
    }
  }

  static Future<ApiResult<List<Source>>> getSourcesByCategoryId(
      String categoryId) async {
    Uri url = Uri.https(baseUrl, Endpoints.sources, {"category": categoryId});

    try {
      http.Response response =
          await http.get(url, headers: {"X-Api-Key": dotenv.env["API_KEY"]!});
      var json = jsonDecode(response.body);
      SourcesModel sourcesModel = SourcesModel.fromJson(json);
      if (sourcesModel.status == 'ok') {
        return Success(data: sourcesModel.sources ?? []);
      } else {
        return ServerError(
            code: sourcesModel.code ?? "",
            message: sourcesModel.message ?? "Something Went Wrong 🤔");
      }
    } on Exception catch (e) {
      return CodeError(exception: e);
    }
  }

  static Future<ApiResult<NewsModel>> getTopHeadlinesBySourceId(
      String sourceId) async {
    Uri url = Uri.https(baseUrl, Endpoints.topHeadlines, {"sources": sourceId});

    try {
      http.Response response =
          await http.get(url, headers: {"X-Api-Key": dotenv.env["API_KEY"]!});
      var json = jsonDecode(response.body);
      NewsModel newsModel = NewsModel.fromJson(json);
      if (newsModel.status == 'ok') {
        return Success(data: newsModel);
      } else {
        return ServerError(
            code: newsModel.code ?? "",
            message: newsModel.message ?? "Something Went Wrong 🤔");
      }
    } on Exception catch (e) {
      return CodeError(exception: e);
    }
  }
}
