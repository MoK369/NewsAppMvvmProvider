import 'package:flutter/material.dart';
import 'package:news/modules/home/pages/categories/view_models/category_sources_view_model.dart';
import 'package:news/modules/home/pages/categories/widgets/tab_bar_of_sources_with_their_articles.dart';
import 'package:provider/provider.dart';

class InSpecificCategoryView extends StatefulWidget {
  final String categoryId;

  const InSpecificCategoryView({super.key, required this.categoryId});

  @override
  State<InSpecificCategoryView> createState() => _InSpecificCategoryViewState();
}

class _InSpecificCategoryViewState extends State<InSpecificCategoryView> {
  CategorySourcesViewModel inSpecificCategoryViewModel =
      CategorySourcesViewModel();

  @override
  void initState() {
    super.initState();
    inSpecificCategoryViewModel.getSourcesByCategoryId(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => inSpecificCategoryViewModel,
      child: Consumer<CategorySourcesViewModel>(
        builder: (context, inSpecificCategoryViewModel, child) {
          if (inSpecificCategoryViewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (inSpecificCategoryViewModel.errorMessage != null) {
            // String message = ApiErrors.checkApiError(snapshot.error!);
            return Center(
                child: Text(inSpecificCategoryViewModel.errorMessage!));
          } else {
            return TabBarOfSources(
              sources: inSpecificCategoryViewModel.sources!,
            );
          }
        },
      ),
    );
  }
}
