import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppLocalizations.dart';
import 'Theme_provider.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          localizations!.notifications,
          style: TextStyle(fontSize: 24.0, color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              margin: EdgeInsets.only(right: 18),
              child: Image.asset(
                isDarkMode ? 'assets/icons/trash-outline-dark-theme.png' : 'assets/icons/trash-outline.png',
                width: 32.0,
                height: 32.0,
                scale: 0.9,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          localizations.notificationPage,
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
      ),
    );
  }
}
