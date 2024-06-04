import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Theme_provider.dart';
import 'AppLocalizations.dart';
import 'database.dart';

class AccountSelectionPage extends StatelessWidget {
  final ValueChanged<Map<String, dynamic>> onAccountSelected;

  AccountSelectionPage({required this.onAccountSelected});

  Future<List<Map<String, dynamic>>> _fetchAccounts() async {
    return await DatabaseHelper().getAccounts();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.customTheme == 'dark';
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.chooseAccount ?? 'Выберите счет'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchAccounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка загрузки данных'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Нет доступных счетов'));
          } else {
            final accounts = snapshot.data!;
            return ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final account = accounts[index];
                return GestureDetector(
                  onTap: () => onAccountSelected(account),
                  child: Container(

                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          account['iconPath'],
                          width: 32,
                          height: 32,
                        ),
                        SizedBox(width: 20),
                        Text(
                          account['category'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
