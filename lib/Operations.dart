import 'package:flutter/material.dart';
import 'main.dart'; // Ensure this file exists in your project
import 'PlanningPage.dart';
import 'ProfilePage.dart';

class OperationsPage extends StatefulWidget {
  @override
  _OperationsPageState createState() => _OperationsPageState();
}

class _OperationsPageState extends State<OperationsPage> {
  int _selectedIndex = 1; // Current page index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        elevation: 0,
        title: Text(
          'Операции',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Остаток',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              '2 000 ₸',
              style: TextStyle(fontSize: 24.0),
            ),
            Divider(),
            Text(
              'В ПРОШЛОМ МЕСЯЦЕ',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            buildTransactionItem('3 марта 2023', '- 1000 ₸', 'Финансовая подушка'),
            buildTransactionItem('3 марта 2023', '- 500 ₸', 'Пятерочка - Питание'),
            SizedBox(height: 20.0),
            Text(
              'В ЭТОМ МЕСЯЦЕ',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            buildTransactionItem('1 марта 2023', '+ 3 000 ₸', 'Пенсия'),
            buildTransactionItem('1 марта 2023', '+ 2 000 ₸', 'От бабушки - Работа'),
            buildTransactionItem('1 марта 2023', '+ 1 000 ₸', 'Supporting text'),
            SizedBox(height: 20.0),
            Text(
              'ПЛАНЫ НА БУДУЩЕЕ',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            buildTransactionItem('3 марта 2023', '- 1000 ₸', 'Финансовая подушка'),
            buildTransactionItem('3 марта 2023', '- 500 ₸', 'Пятерочка - Питание'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
              // Current page, do nothing
                break;
              case 2:
              // Placeholder for Adding Page
                break;
              case 3:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PlanningPage()),
                );
                break;
              case 4:
                Navigator.pushReplacement(
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
                ? Image.asset('assets/icons/active-home.png', width: 60.0, height: 60.0, scale: 0.8)
                : Image.asset('assets/icons/home.png', width: 60.0, height: 60.0, scale: 0.8),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Image.asset('assets/icons/active-wallet.png', width: 60.0, height: 60.0, scale: 0.8)
                : Image.asset('assets/icons/wallet.png', width: 60.0, height: 60.0, scale: 0.8),
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
                ? Image.asset('assets/icons/active-clipboard.png', width: 60.0, height: 60.0, scale: 0.8)
                : Image.asset('assets/icons/clipboard.png', width: 60.0, height: 60.0, scale: 0.8),
            label: 'Планы',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? Image.asset('assets/icons/active-person.png', width: 60.0, height: 60.0, scale: 0.8)
                : Image.asset('assets/icons/person.png', width: 60.0, height: 60.0, scale: 0.8),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }

  Widget buildTransactionItem(String date, String amount, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.0),
        Text(
          amount,
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          description,
          style: TextStyle(fontSize: 16.0),
        ),
        Divider(),
      ],
    );
  }
}
