import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppLocalizations.dart';
import 'Theme_provider.dart';
import 'main.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final isDarkMode = themeProvider.isDarkMode;
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations!.settings),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.theme,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: Text(
                      localizations.changeTheme,
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                    ),
                    trailing: DropdownButton<String>(
                      value: themeProvider.customTheme,
                      icon: SizedBox.shrink(),
                      iconSize: 0,
                      elevation: 16,
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                      underline: Container(
                        height: 2,
                        color: theme.primaryColor,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          final provider = Provider.of<ThemeProvider>(context, listen: false);
                          provider.setCustomTheme(newValue);
                        }
                      },
                      items: <String>['light', 'dark', 'nature']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.language,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: Text(
                      localizations.selectLanguage,
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                    ),
                    trailing: DropdownButton<Locale>(
                      value: Localizations.localeOf(context),
                      icon: SizedBox.shrink(),
                      iconSize: 0,
                      elevation: 16,
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                      underline: Container(
                        height: 2,
                        color: theme.primaryColor,
                      ),
                      onChanged: (Locale? newValue) {
                        if (newValue != null) {
                          MyApp.setLocale(context, newValue);
                        }
                      },
                      items: <Locale>[
                        Locale('en', ''),
                        Locale('ru', ''),
                        Locale('kk', ''),
                      ].map<DropdownMenuItem<Locale>>((Locale value) {
                        return DropdownMenuItem<Locale>(
                          value: value,
                          child: Text(value.languageCode.toUpperCase()),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
