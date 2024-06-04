import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AddOperationsPage.dart';
import 'OperationsPage.dart';
import 'database.dart';
import 'Theme_provider.dart';
import 'AppLocalizations.dart';
import 'main.dart';
import 'ProfilePage.dart';
import 'AddPlansPage.dart';

class PlanningPage extends StatefulWidget {
  @override
  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  int _selectedIndex = 3;
  List<Map<String, dynamic>> _plans = [];

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    List<Map<String, dynamic>> plans = await DatabaseHelper().getPlans();
    setState(() {
      _plans = plans;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.customTheme == 'dark';
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations?.planningTitle ?? 'Планирование бюджета на месяц',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              localizations?.planningTitle2 ?? 'Добавьте категорию для отслеживания',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 17.0,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 100.0,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var plan in _plans)
                InkWell(
                  onTap: () {
                    // Implement navigation to edit plan page
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 36.0,
                                  child: Image.asset(
                                    plan['iconPath'] ?? 'assets/icons/default-icon.png',
                                    width: 40.0,
                                    height: 40.0,
                                    scale: 0.7,
                                  ),
                                ),
                                SizedBox(width: 15.0),
                                Text(
                                  plan['category'] ?? '',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyLarge?.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${plan['amount']} \u20B8',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyLarge?.color,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${plan['plannedAmount']} \u20B8',
                                  style: TextStyle(
                                    color: (plan['plannedAmount'] < 0)
                                        ? Color(0xFFB3261E)
                                        : Color(0xFF10B981),
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              Container(
                width: double.infinity,
                height: 2.0,
                color: Theme.of(context).dividerColor,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddPlansPage()),
                      );
                    },
                    child: Text(
                      localizations?.addCategory ?? '+ Добавить категорию',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).cardColor,
                      elevation: 0,
                      minimumSize: Size(200, 30),
                      textStyle: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OperationsPage()),
                );
                break;
              case 2:
              // Navigate to the Adding Page
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanningPage()),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
                break;
            }
          });
        },
        iconSize: 32.0,
        selectedItemColor: Color(0xFF10B981),
        unselectedItemColor: isDarkMode ? Colors.white70 : Colors.black,
        selectedLabelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        unselectedLabelStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
        backgroundColor: Theme.of(context).cardColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              isDarkMode
                  ? (_selectedIndex == 0
                  ? 'assets/icons/active-home.png'
                  : 'assets/icons/home-outline-dark-theme.png')
                  : (_selectedIndex == 0
                  ? 'assets/icons/active-home.png'
                  : 'assets/icons/home.png'),
              width: 60.0,
              height: 60.0,
              scale: 0.8,
            ),
            label: localizations?.main ?? 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              isDarkMode
                  ? (_selectedIndex == 1
                  ? 'assets/icons/active-wallet.png'
                  : 'assets/icons/wallet-outline-dark-theme.png')
                  : (_selectedIndex == 1
                  ? 'assets/icons/active-wallet.png'
                  : 'assets/icons/wallet.png'),
              width: 60.0,
              height: 60.0,
              scale: 0.8,
            ),
            label: localizations?.operations ?? 'Операции',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 72.0,
              height: 72.0,
              child: Transform.translate(
                offset: Offset(0.0, 8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddOperationsPage()),
                    );
                  },
                  backgroundColor: Color(0xFF10B981),
                  child: Icon(Icons.add, color: Colors.white, size: 32.0),
                  shape: CircleBorder(),
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              isDarkMode
                  ? (_selectedIndex == 3
                  ? 'assets/icons/active-clipboard.png'
                  : 'assets/icons/clipboard-outline-dark-theme.png')
                  : (_selectedIndex == 3
                  ? 'assets/icons/active-clipboard.png'
                  : 'assets/icons/clipboard.png'),
              width: 60.0,
              height: 60.0,
              scale: 0.8,
            ),
            label: localizations?.plans ?? 'Планы',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              isDarkMode
                  ? (_selectedIndex == 4
                  ? 'assets/icons/active-person.png'
                  : 'assets/icons/person-outline-dark-theme.png')
                  : (_selectedIndex == 4
                  ? 'assets/icons/active-person.png'
                  : 'assets/icons/person.png'),
              width: 60.0,
              height: 60.0,
              scale: 0.8,
            ),
            label: localizations?.profilepage ?? 'Профиль',
          ),
        ],
      ),
    );
  }
}
