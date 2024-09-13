import 'package:flutter/material.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/core/providers/themes/themes_provider.dart';
import 'package:news/core/themes/app_themes.dart';
import 'package:news/core/widgets/articles_List_view/articles_list_view.dart';
import 'package:news/core/widgets/background_pattern/background_pattern.dart';
import 'package:news/modules/search/view_models/everything_articles_view_model.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "SearchScreen";

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool isSearchClicked = false;
  late ThemesProvider themesProvider;
  EverythingArticlesViewModel everythingArticlesViewModel =
      EverythingArticlesViewModel();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    themesProvider = Provider.of(context);
    return ChangeNotifierProvider(
        create: (context) => everythingArticlesViewModel,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: const SizedBox(),
                leadingWidth: 0,
                toolbarHeight: size.height * 0.08,
                title: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextField(
                    controller: textEditingController,
                    style: theme.textTheme.labelMedium,
                    onSubmitted: (value) {
                      onSearchButtonClick();
                    },
                    decoration: InputDecoration(
                      hintText: LocalesProvider.getTrans(context).searchArticle,
                      suffixIcon: IconButton(
                          onPressed: () {
                            onSearchButtonClick();
                          },
                          icon: Icon(
                            Icons.search,
                            size: 30,
                            color: getIconColor(),
                          )),
                      prefixIcon: IconButton(
                          onPressed: () {
                            onClearButtonClick();
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 30,
                            color: getIconColor(),
                          )),
                    ),
                  ),
                ),
              ),
              body: BgPattern(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Visibility(
                    visible: !isSearchClicked,
                    child: Expanded(
                      child: Center(
                          child: ImageIcon(
                        const AssetImage("assets/icons/window_search_icon.png"),
                        size: 80,
                        color: getIconColor(),
                      )),
                    ),
                  ),
                  Visibility(
                    visible: isSearchClicked,
                    child:
                        Expanded(child: Consumer<EverythingArticlesViewModel>(
                      builder: (context, everythingArticlesViewModel, child) {
                        if (everythingArticlesViewModel.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (everythingArticlesViewModel.errorMessage !=
                            null) {
                          return Center(
                              child: Text(
                                  everythingArticlesViewModel.errorMessage ??
                                      ""));
                        } else {
                          return ArticlesListView(
                              newsModel: everythingArticlesViewModel.newsModel,
                              showClearAllResults: true,
                              onClearResultsClick: onClearResultsClick);
                        }
                      },
                    )),
                  )
                ],
              ))),
        ));
  }

  void onSearchButtonClick() {
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(LocalesProvider.getTrans(context).searchFieldEmpty)));
    } else {
      setState(() {
        everythingArticlesViewModel.getNewsByQuery(textEditingController.text);
        isSearchClicked = true;
        FocusManager.instance.primaryFocus?.unfocus();
      });
    }
  }

  void onClearButtonClick() {
    if (textEditingController.text.isNotEmpty) {
      textEditingController.clear();
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.pop(context);
    }
  }

  void onClearResultsClick() {
    setState(() {
      everythingArticlesViewModel.newsModel = null;
      textEditingController.clear();
      isSearchClicked = false;
    });
  }

  Color getIconColor() {
    return themesProvider.isDark()
        ? AppThemes.darkOnPrimaryColor
        : AppThemes.lightOnPrimaryColor;
  }
}
