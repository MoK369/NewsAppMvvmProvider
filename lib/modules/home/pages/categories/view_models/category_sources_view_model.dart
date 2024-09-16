import 'package:news/core/bases/base_view_model/base_view_model.dart';
import 'package:news/core/bases/base_view_state/base_view_state.dart';
import 'package:news/core/models/sources_model.dart';
import 'package:news/core/services/apis/api_manager.dart';
import 'package:news/core/services/apis/api_result.dart';

class CategorySourcesViewModel extends BaseViewModel<List<Source>> {
  CategorySourcesViewModel() : super(viewState: LoadingState());

  Future<void> getSourcesByCategoryId(String categoryId) async {
    refreshWithState(LoadingState());
    ApiResult<List<Source>> apiResult =
        await ApiManager.getSourcesByCategoryId(categoryId);
    switch (apiResult) {
      case Success():
        refreshWithState(SuccessState(data: apiResult.data));
        break;
      case ServerError():
        refreshWithState(ErrorState(serverError: apiResult));
        break;
      case CodeError():
        refreshWithState(ErrorState(codeError: apiResult));
        break;
    }
  }
}
