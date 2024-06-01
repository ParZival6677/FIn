import 'package:flutter/material.dart';
import 'main.dart';
import 'ProfilePage.dart';
import 'Operations.dart';
import 'package:provider/provider.dart';
import 'Theme_provider.dart';
import 'AppLocalizations.dart';

class PlanningPage extends StatefulWidget {
  @override
  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.customTheme == 'dark';
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations!.planningTitle,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  localizations.planningTitle2,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 17.0,
                  ),
                ),
              ],
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
            children: [
              Row(
                children: [
                  SizedBox(height: 20.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [],
                        ),
                        SizedBox(height: 20.0),
                        Divider(
                          color: Theme.of(context).dividerColor,
                          height: 2.0,
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                localizations.addPlanningCategory,
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 20,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(200, 30),
                                textStyle: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
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
            label: localizations.main,
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
            label: localizations.operations,
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 72.0,
              height: 72.0,
              child: Transform.translate(
                offset: Offset(0.0, 8.0),
                child: FloatingActionButton(
                  onPressed: () {},
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
            label: localizations.plans,
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
            label: localizations.profilepage,
          ),
        ],
      ),
    );
  }
}
