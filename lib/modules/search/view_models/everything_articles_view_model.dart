import 'package:news/core/bases/base_view_model/base_view_model.dart';
import 'package:news/core/bases/base_view_state/base_view_state.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/services/apis/api_manager.dart';
import 'package:news/core/services/apis/api_result.dart';

class EverythingArticlesViewModel extends BaseViewModel<NewsModel> {
  EverythingArticlesViewModel() : super(viewState: LoadingState());

  Future<void> getNewsByQuery(String query) async {
    var result = await ApiManager.getNewsByQuery(query);
    switch (result) {
      case Success<NewsModel>():
        refreshWithState(SuccessState(data: result.data));
        break;
      case ServerError<NewsModel>():
        refreshWithState(ErrorState(serverError: result));
        break;
      case CodeError<NewsModel>():
        refreshWithState(ErrorState(codeError: result));
        break;
    }
  }
}
