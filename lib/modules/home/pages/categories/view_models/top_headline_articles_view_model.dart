import 'package:news/core/bases/base_view_model/base_view_model.dart';
import 'package:news/core/bases/base_view_state/base_view_state.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/services/apis/api_manager.dart';
import 'package:news/core/services/apis/api_result.dart';

class TopHeadlinesArticlesViewModel extends BaseViewModel<NewsModel> {
  TopHeadlinesArticlesViewModel() : super(viewState: LoadingState());

  Future<void> getTopHeadlinesBySourceId(String sourceId) async {
    refreshWithState(LoadingState());
    ApiResult<NewsModel> apiResult =
        await ApiManager.getTopHeadlinesBySourceId(sourceId);

    switch (apiResult) {
      case Success<NewsModel>():
        refreshWithState(SuccessState(data: apiResult.data));
        break;
      case ServerError<NewsModel>():
        refreshWithState(ErrorState(serverError: apiResult));
        break;
      case CodeError<NewsModel>():
        refreshWithState(ErrorState(codeError: apiResult));
        break;
    }
  }
}
