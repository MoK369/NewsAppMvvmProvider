import 'package:flutter/material.dart';
import 'package:news/core/api_error_message/api_error_message.dart';
import 'package:news/core/bases/base_view_state/base_view_state.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/widgets/articles_List_view/articles_list_view.dart';
import 'package:news/modules/home/pages/categories/view_models/top_headline_articles_view_model.dart';
import 'package:provider/provider.dart';

class ArticlesSection extends StatefulWidget {
  final String sourcedId;

  const ArticlesSection({super.key, required this.sourcedId});

  @override
  State<ArticlesSection> createState() => _ArticlesSectionState();
}

class _ArticlesSectionState extends State<ArticlesSection> {
  final TopHeadlinesArticlesViewModel
      tabBarOfSourcesWithTheirArticlesViewModel =
      TopHeadlinesArticlesViewModel();

  @override
  void initState() {
    super.initState();
    tabBarOfSourcesWithTheirArticlesViewModel
        .getTopHeadlinesBySourceId(widget.sourcedId);
  }

  @override
  void didUpdateWidget(covariant ArticlesSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sourcedId != widget.sourcedId) {
      tabBarOfSourcesWithTheirArticlesViewModel
          .getTopHeadlinesBySourceId(widget.sourcedId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => tabBarOfSourcesWithTheirArticlesViewModel,
      child: Consumer<TopHeadlinesArticlesViewModel>(
        builder: (context, topHeadlinesArticlesViewModel, child) {
          var state = tabBarOfSourcesWithTheirArticlesViewModel.viewState;
          switch (state) {
            case LoadingState<NewsModel>():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ErrorState<NewsModel>():
              return Center(
                  child: Text(ApiErrorMessage.getErrorMessage(
                      serverError: state.serverError,
                      codeError: state.codeError)));
            case SuccessState<NewsModel>():
              return ArticlesListView(newsModel: state.data);
          }
        },
      ),
    );
  }
}
