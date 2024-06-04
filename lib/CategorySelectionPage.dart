import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Theme_provider.dart';
import 'AppLocalizations.dart';

class CategorySelectionPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final ValueChanged<String> onCategorySelected;

  CategorySelectionPage({
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.customTheme == 'dark';
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.chooseCategory ?? 'Выберите категорию'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categories.length + 1, // Increment itemCount for the button
          itemBuilder: (context, index) {
            if (index == categories.length) {
              // Return the Add Category button as the last item
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: () {
                    // Add category logic
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Color(0xFF10B981)),
                      SizedBox(width: 8),
                      Text(
                        localizations?.addCategory ?? 'Добавить категорию',
                        style: TextStyle(color: Color(0xFF10B981)),
                      ),
                    ],
                  ),
                ),
              );
            }

            final category = categories[index];
            if (category.containsKey('header')) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  category['header'],
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () => Navigator.pop(context, category['category']),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        category['iconPath'],
                        width: 32,
                        height: 32,
                      ),
                      SizedBox(width: 20),
                      Text(
                        localizations?.translate(category['category']) ?? category['category'],
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
