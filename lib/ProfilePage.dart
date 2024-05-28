import 'package:flutter/material.dart';
import 'PlanningPage.dart';
import 'main.dart';
import 'Operations.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
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
                      'Вы вошли через номер телефона',
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    _buildButton(
                      iconPath: 'assets/icons/notifications-outline.png',
                      text: 'Настройки уведомлений',
                      onPressed: () {

                      },
                    ),
                    _buildButton(
                      iconPath: 'assets/icons/settings-outline.png',
                      text: 'Настройки аккаунта',
                      onPressed: () {

                      },
                    ),
                    _buildButton(
                      iconPath: 'assets/icons/help-circle-outline.png',
                      text: 'Помощь',
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _buildButton(
                  iconPath: 'assets/icons/exit-outline.png',
                  text: 'Выход',
                  onPressed: () {

                  },
                ),
              ),
              // Ваши пустые контейнеры здесь
              Container(),
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
              // Navigate to Home Page
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
              // Navigate to Profile Page
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
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Image.asset('assets/icons/active-home.png', width: 60.0, height: 60.0, scale: 0.8,)
                : Image.asset('assets/icons/home.png', width: 60.0, height: 60.0, scale: 0.8,),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Image.asset('assets/icons/active-wallet.png', width: 60.0, height: 60.0, scale: 0.8,)
                : Image.asset('assets/icons/wallet.png', width: 60.0, height: 60.0, scale: 0.8,),
            label: 'Операции',
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
            icon: _selectedIndex == 3
                ? Image.asset('assets/icons/active-clipboard.png', width: 60.0, height: 60.0, scale: 0.8,)
                : Image.asset('assets/icons/clipboard.png', width: 60.0, height: 60.0, scale: 0.8,),
            label: 'Планы',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? Image.asset('assets/icons/active-person.png', width: 60.0, height: 60.0, scale: 0.8,)
                : Image.asset('assets/icons/person.png', width: 60.0, height: 60.0, scale: 0.8,),
            label: 'Профиль',
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
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}