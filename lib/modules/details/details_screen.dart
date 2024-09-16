import 'package:flutter/material.dart';
import 'package:news/core/models/news_model.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/core/providers/themes/themes_provider.dart';
import 'package:news/core/widgets/background_pattern/background_pattern.dart';
import 'package:news/core/widgets/news_card/news_card.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = "DetailScreen";

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final ThemesProvider themesProvider = Provider.of(context);
    final Article article =
        ModalRoute.settingsOf(context)?.arguments as Article;
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalesProvider.getTrans(context).newsTitle),
        toolbarHeight: 60,
        centerTitle: true,
        leadingWidth: 80,
      ),
      body: BgPattern(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
              child: NewsCard(
                article: article,
                textHorizontalPadding: 10,
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(25)),
                width: size.width * 0.9,
                height: size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          article.description ?? "",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        launchLink(context, Uri.parse(article.url!));
                      },
                      title: Text(
                        textAlign: TextAlign.end,
                        LocalesProvider.getTrans(context).viewArticle,
                        style: theme.textTheme.labelMedium,
                      ),
                      trailing: Icon(
                        Icons.play_arrow,
                        color: themesProvider.isDark()
                            ? Colors.white
                            : Colors.black,
                      ),
                    )
                  ],
                )),
          ],
        ),
      )),
    );
  }

  Future<void> launchLink(BuildContext context, Uri url) async {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    String message = LocalesProvider.getTrans(context).couldNotUrl;
    if (!await launchUrl(url)) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
    return;
  }
}
