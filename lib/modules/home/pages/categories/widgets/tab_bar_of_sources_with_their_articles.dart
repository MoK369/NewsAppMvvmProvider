import 'package:flutter/material.dart';
import 'package:news/core/models/sources_model.dart';
import 'package:news/core/widgets/articles_List_view/articles_list_view.dart';
import 'package:news/modules/home/pages/categories/view_models/top_headline_articles_view_model.dart';
import 'package:news/modules/home/pages/categories/widgets/tab_item.dart';
import 'package:provider/provider.dart';

class TabBarOfSources extends StatefulWidget {
  final List<Source> sources;

  const TabBarOfSources({super.key, required this.sources});

  @override
  State<TabBarOfSources> createState() => _TabBarOfSourcesState();
}

class _TabBarOfSourcesState extends State<TabBarOfSources>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late String selectedSourceId;
  TopHeadlinesArticlesViewModel tabBarOfSourcesWithTheirArticlesViewModel =
      TopHeadlinesArticlesViewModel();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.sources.length, vsync: this);
    selectedSourceId =
        widget.sources.isNotEmpty ? widget.sources[0].id ?? "" : "";
    tabBarOfSourcesWithTheirArticlesViewModel
        .getTopHeadlinesBySourceId(selectedSourceId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => tabBarOfSourcesWithTheirArticlesViewModel,
      child: Column(
        children: [
          TabBar(
              isScrollable: true,
              controller: tabController,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              overlayColor: WidgetStateColor.transparent,
              tabAlignment: TabAlignment.start,
              labelPadding: const EdgeInsets.symmetric(horizontal: 15),
              onTap: (value) {
                if (selectedSourceId != widget.sources[value].id) {
                  setState(() {
                    tabController.index = value;
                    selectedSourceId = widget.sources[value].id!;
                    tabBarOfSourcesWithTheirArticlesViewModel
                        .getTopHeadlinesBySourceId(selectedSourceId);
                  });
                }
              },
              tabs: widget.sources.map(
                (source) {
                  return TabItem(
                      isSelected:
                          tabController.index == widget.sources.indexOf(source),
                      title: source.name ?? "");
                },
              ).toList()),
          Expanded(child: Consumer<TopHeadlinesArticlesViewModel>(
            builder:
                (context, tabBarOfSourcesWithTheirArticlesViewModel, child) {
              if (tabBarOfSourcesWithTheirArticlesViewModel.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (tabBarOfSourcesWithTheirArticlesViewModel
                      .errorMessage !=
                  null) {
                return Center(
                    child: Text(tabBarOfSourcesWithTheirArticlesViewModel
                            .errorMessage ??
                        ""));
              } else {
                return ArticlesListView(
                    newsModel:
                        tabBarOfSourcesWithTheirArticlesViewModel.newsModel);
              }
            },
          ))
        ],
      ),
    );
  }
}
