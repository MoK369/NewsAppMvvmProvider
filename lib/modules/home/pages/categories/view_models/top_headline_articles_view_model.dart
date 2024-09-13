import 'package:flutter/material.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/services/apis/api_manager.dart';

class TopHeadlinesArticlesViewModel extends ChangeNotifier {
  NewsModel? newsModel;
  bool isLoading = false;
  String? errorMessage;

  Future<void> getTopHeadlinesBySourceId(String sourceId) async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await ApiManager.getTopHeadlinesBySourceId(sourceId);
      isLoading = false;
      if (response?.status == "ok") {
        newsModel = response;
      } else {
        errorMessage = response?.message ?? "";
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
