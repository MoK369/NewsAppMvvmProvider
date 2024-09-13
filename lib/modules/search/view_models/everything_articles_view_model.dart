import 'package:flutter/material.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/services/apis/api_manager.dart';

class EverythingArticlesViewModel extends ChangeNotifier {
  NewsModel? newsModel;
  bool isLoading = false;
  String? errorMessage;

  Future<void> getNewsByQuery(String query) async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await ApiManager.getNewsByQuery(query);
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
