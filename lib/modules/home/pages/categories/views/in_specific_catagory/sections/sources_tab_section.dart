import 'package:flutter/material.dart';
import 'package:news/core/models/sources_model.dart';
import 'package:news/modules/home/pages/categories/views/in_specific_catagory/sections/articles_section.dart';
import 'package:news/modules/home/pages/categories/widgets/tab_item.dart';

class SourcesTabSection extends StatefulWidget {
  final List<Source> sources;

  const SourcesTabSection({super.key, required this.sources});

  @override
  State<SourcesTabSection> createState() => _SourcesTabSectionsState();
}

class _SourcesTabSectionsState extends State<SourcesTabSection>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late String selectedSourceId;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.sources.length, vsync: this);
    selectedSourceId =
        widget.sources.isNotEmpty ? widget.sources[0].id ?? "" : "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Expanded(child: ArticlesSection(sourcedId: selectedSourceId))
      ],
    );
  }
}
