import 'package:flutter/material.dart';
import 'package:news/core/api_error_message/api_error_message.dart';
import 'package:news/core/bases/base_view_state/base_view_state.dart';
import 'package:news/core/models/sources_model.dart';
import 'package:news/modules/home/pages/categories/view_models/category_sources_view_model.dart';
import 'package:news/modules/home/pages/categories/views/in_specific_catagory/sections/sources_tab_section.dart';
import 'package:provider/provider.dart';

class InSpecificCategoryView extends StatefulWidget {
  final String categoryId;

  const InSpecificCategoryView({super.key, required this.categoryId});

  @override
  State<InSpecificCategoryView> createState() => _InSpecificCategoryViewState();
}

class _InSpecificCategoryViewState extends State<InSpecificCategoryView> {
  CategorySourcesViewModel categorySourcesViewModel =
      CategorySourcesViewModel();

  @override
  void initState() {
    super.initState();
    categorySourcesViewModel.getSourcesByCategoryId(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => categorySourcesViewModel,
      child: Consumer<CategorySourcesViewModel>(
        builder: (context, categorySourcesViewModel, child) {
          var state = categorySourcesViewModel.viewState;
          switch (state) {
            case LoadingState<List<Source>>():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ErrorState<List<Source>>():
              return Center(
                  child: Text(
                      textAlign: TextAlign.center,
                      ApiErrorMessage.getErrorMessage(
                          codeError: state.codeError,
                          serverError: state.serverError)));
            case SuccessState<List<Source>>():
              return SourcesTabSection(sources: state.data);
          }
        },
      ),
    );
  }
}
