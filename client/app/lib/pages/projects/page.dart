import 'package:app/pages/projects/tiles/config.dart';
import 'package:flutter/material.dart';
import '../_templates/base_image_page.dart';
import 'tiles/tile.dart';

class ProjectsPage extends BaseImagePageTemplate {
  ProjectsPage({super.key});

  @override
  ProjectsPageState createState() => ProjectsPageState();
}

class ProjectsPageState extends BaseImagePageTemplateState<ProjectsPage> {
  bool isFilterVisible = true; // Visibility control for the filter menu

  String selectedCategory = "All Categories";
  String selectedLanguage = "All Languages";

  List<ProjectTile> tiles = PROJECT_TILES;
  List<String> categories = PROJECT_TILES.map((e) => e.category).toSet().toList()..insert(0, "All Categories");
  List<String> languages = PROJECT_TILES.map((e) => e.primaryLanguage).toSet().toList()..insert(0, "All Languages");

  List<ProjectTile> filteredTiles = [];
  List<String> availableLanguages = [];

  Map<String, int> categoryCount = {};
  Map<String, int> languageCount = {};

@override
void initState() {
  super.initState();
  filteredTiles = List.from(tiles);
  availableLanguages = languages; // Initially, all languages are available
  _countProjectsPerCategory();
  _countProjectsPerLanguage();
}

  void _countProjectsPerCategory() {
    categoryCount = {
      for (var category in categories) category: tiles.where((tile) => tile.category == category).length
    };
    categoryCount['All Categories'] = tiles.length; // Count for 'All' category
  }

  void _countProjectsPerLanguage() {
    languageCount = {
      for (var language in languages) language: tiles.where((tile) => tile.primaryLanguage == language).length
    };
    languageCount['All Languages'] = tiles.length; // Count for 'All' category
  }

  void applyCategoryFilter(String category) {
    setState(() {
      selectedCategory = category;
      if (category == "All Categories") {
        availableLanguages = languages;
      } else {
        availableLanguages = tiles
          .where((tile) => tile.category == category)
          .map((e) => e.primaryLanguage)
          .toSet()
          .toList()..insert(0, "All Languages");
      }
      selectedLanguage = "All Languages"; // Reset language filter upon category change
      languageCount['All Languages'] = categoryCount[category]!;
      applyCombinedFilter();
    });
  }

  void applyLanguageFilter(String language) {
    setState(() {
      selectedLanguage = language;
      applyCombinedFilter();
    });
  }

  void applyCombinedFilter() {
    filteredTiles = tiles.where((tile) {
      final bool categoryMatches = selectedCategory == "All Categories" || tile.category == selectedCategory;
      final bool languageMatches = selectedLanguage == "All Languages" || tile.primaryLanguage == selectedLanguage;
      return categoryMatches && languageMatches;
    }).toList();
  }

  Widget buildFilterChip(String label, int count, String selectedFilter, ValueChanged<String> onSelected) {
    bool isSelected = selectedFilter == label;
    return ChoiceChip(
      label: Text('$label ($count)'),
      selected: isSelected,
      onSelected: (_) => onSelected(label),
      selectedColor: Colors.blueGrey,
      backgroundColor: Colors.grey,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 13),
    );
  }

  Widget buildCategoryFilterList() {
    return Wrap(
      spacing: 8.0,
      children: categories.map((category) {
        return buildFilterChip(category, categoryCount[category] ?? 0, selectedCategory, applyCategoryFilter);
      }).toList(),
    );
  }

  Widget buildLanguageFilterList() {
    return Wrap(
      spacing: 8.0,
      children: availableLanguages.map((language) {
        return buildFilterChip(language, languageCount[language] ?? 0, selectedLanguage, applyLanguageFilter);
      }).toList(),
    );
  }

  @override
  Widget getHeroWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: kToolbarHeight + MediaQuery.of(context).padding.top,
        bottom: 65
      ),
      decoration: BoxDecoration(color: Colors.black.withOpacity(.8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title "Projects"
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Projects",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          // Category filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: buildCategoryFilterList(),
          ),
          const SizedBox(height: 10.0),
          // Language filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: buildLanguageFilterList(),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 24.0,
              ),
              itemCount: filteredTiles.length,
              itemBuilder: (context, index) {
                return filteredTiles[index];
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: getPageHeaderWidget(context),
      body: getPageWidget(context),
      drawer: getPageDrawerWidget(context),
      bottomNavigationBar: getPageFooterWidget(context),
    );
  }
}