import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppLocalizations.dart';
import 'Theme_provider.dart';
import 'Settings.dart';
import 'main.dart';
import 'PlanningPage.dart';
import 'MapsPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 4;

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
                Row(
                  children: [
                    Text(
                      localizations!.profile,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  '+7 (777) 777-77-77',
                  style: TextStyle(
                    color: Color(0xFF7F7F7F),
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.location_on, size: 32),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapsPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    _buildButton(
                      iconPath:'assets/icons/notifications-outline.png',
                      text: localizations.notifications_settings,
                      onPressed: () {},
                    ),
                    _buildButton(
                      iconPath: 'assets/icons/settings-outline.png',
                      text: localizations.settings,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsPage()),
                        );
                      },
                    ),
                    _buildButton(
                      iconPath: 'assets/icons/help-circle-outline.png',
                      text: localizations.help,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _buildButton(
                  iconPath: 'assets/icons/exit-outline.png',
                  text: localizations.signOut,
                  onPressed: () {},
                ),
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
              // Navigate to Operations Page
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

  Widget _buildButton({required String iconPath, required String text, required VoidCallback onPressed}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 48.0,
              height: 48.0,
              scale: 0.8,
            ),
            SizedBox(width: 12.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
