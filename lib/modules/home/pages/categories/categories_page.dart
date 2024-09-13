import 'package:flutter/material.dart';
import 'package:news/core/models/category_model.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/modules/home/pages/categories/views/all_category_view.dart';
import 'package:news/modules/home/pages/categories/views/in_specific_category_view.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  final void Function(String categoryId, String categoryLabel) onTap;
  final String? currentCategoryId;

  const CategoriesPage(
      {super.key, required this.onTap, required this.currentCategoryId});

  static List<CategoryModel> categories = [];

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late final LocalesProvider localesProvider;
  late final ThemeData theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    CategoriesPage.categories = [
      CategoryModel(
        id: 'sports',
        label: LocalesProvider.getTrans(context).sports,
        imagePath: "assets/images/sports.png",
        bgColor: const Color(0xFFC91C22),
      ),
      CategoryModel(
        id: "technology",
        label: LocalesProvider.getTrans(context).technology,
        imagePath: "assets/images/technology.png",
        bgColor: const Color(0xFF003E90),
      ),
      CategoryModel(
          id: "health",
          label: LocalesProvider.getTrans(context).health,
          imagePath: "assets/images/health.png",
          bgColor: const Color(0xFFED1E79)),
      CategoryModel(
          id: 'business',
          label: LocalesProvider.getTrans(context).business,
          bgColor: const Color(0xFFCF7E48),
          imagePath: "assets/images/bussines.png"),
      CategoryModel(
          id: "general",
          label: LocalesProvider.getTrans(context).general,
          imagePath: "assets/images/general.png",
          bgColor: const Color(0xFF4882CF)),
      CategoryModel(
          id: "science",
          label: LocalesProvider.getTrans(context).science,
          imagePath: "assets/images/science.png",
          bgColor: const Color(0xFFF2D352)),
      CategoryModel(
          id: "entertainment",
          label: LocalesProvider.getTrans(context).entertainment,
          imagePath: "assets/images/entertainment.png",
          bgColor: Colors.orange)
    ];
    theme = Theme.of(context);
    localesProvider = Provider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.currentCategoryId == null
        ? AllCategoryView(
            onCategoryCardTap: (categoryId, categoryLabel) {
              widget.onTap(categoryId, categoryLabel);
            },
          )
        : InSpecificCategoryView(categoryId: widget.currentCategoryId!);
  }
}
