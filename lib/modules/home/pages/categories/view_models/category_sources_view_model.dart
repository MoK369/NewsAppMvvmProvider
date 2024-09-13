import 'package:flutter/material.dart';
import 'package:news/core/models/sources_model.dart';
import 'package:news/core/services/apis/api_manager.dart';

class CategorySourcesViewModel extends ChangeNotifier {
  List<Source>? sources;
  String? errorMessage;
  bool isLoading = false;

  Future<void> getSourcesByCategoryId(String categoryId) async {
    try {
      isLoading = true;
      notifyListeners();
      var sourcesModel = await ApiManager.getSourcesByCategoryId(categoryId);
      isLoading = false;
      if (sourcesModel?.status == "ok") {
        // Result:
        sources = sourcesModel?.sources ?? [];
      } else {
        // error
        errorMessage = sourcesModel?.message ?? "";
      }
      notifyListeners();
    } catch (e) {
      // show exception error
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
