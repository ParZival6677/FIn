import 'package:flutter/material.dart';
import 'main.dart';
import 'ProfilePage.dart';
import 'Operations.dart';

class PlanningPage extends StatefulWidget {
  @override
  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  int _selectedIndex = 3;

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
                Text(
                  'Планирование бюджета на месяц', // Заголовок страницы
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Добавьте категорию для отслеживания', // Заголовок страницы
                  style: TextStyle(
                    color: Colors.black,
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
            color: Colors.white,
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
                          children: [

                          ],
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: double.infinity,
                          height: 2.0,
                          color: Color(0xFFF2F2F2),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                '+ Добавить категорию',
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 20,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                minimumSize: MaterialStateProperty.all(Size(200, 30)),
                                elevation: MaterialStateProperty.all(0),
                                shadowColor: MaterialStateProperty.all(Colors.white),
                                textStyle: MaterialStateProperty.all(TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 18,
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0), // Пространство между контейнерами
              Container(
                height: 2.0, // Горизонтальная полоса деления
                color: Colors.grey[300],
              ),
              SizedBox(height: 20.0), // Пространство между контейнерами
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Здесь добавьте ваш второй контейнер и его содержимое
                      ],
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
              // Navigate to the HomePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                break;
              case 1:
              // Navigate to the OperationPage
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => OperationsPage()),
              //   );
                break;
              case 2:
              // Navigate to the Adding Page

                break;
              case 3:
              // Navigate to the PlanningPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanningPage()),
                );
                break;
              case 4:
              // Navigate to the ProfilePage
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
}