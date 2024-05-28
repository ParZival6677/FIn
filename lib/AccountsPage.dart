import 'package:flutter/material.dart';
import 'EditAccountsPage.dart';
import 'database.dart';

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  late List<Map<String, dynamic>> _accountsList;
  bool _excludeFromTotal = false;

  @override
  void initState() {
    super.initState();
    _updateAccountsList();
  }

  void _updateAccountsList() async {
    List<Map<String, dynamic>> accounts = await DatabaseHelper().getAccounts();
    setState(() {
      _accountsList = accounts;
    });
  }

  num _calculateTotalBalance() {
    num total = 0;
    if (_accountsList != null) {
      for (var account in _accountsList) {
        if (!_excludeFromTotal) {
          total += account['amount'];
        }
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мои счета'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditAccountsPage()));
              },
              icon: Image.asset(
                'assets/icons/edit-button.png',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/totals.png',
                  width: 50.0,
                  height: 50.0,
                  scale: 0.7,
                ),
                SizedBox(width: 10.0),
                Text(
                  'Итого',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  _calculateTotalBalance().toString() + ' \u20B8',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            color: Color(0xFFF2F2F2),
            height: 1.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0,),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Text(
                  'Включены в итог',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            color: Color(0xFFF2F2F2),
            height: 1.0,
          ),
          Column(
            children: _accountsList.map((account) {
              if (!_excludeFromTotal) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0, ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        account['iconPath'],
                        width: 50.0,
                        height: 50.0,
                        scale: 0.7,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        account['category'],
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        account['amount'].toString() + ' \u20B8',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox(); // Если счет исключен из итога, возвращаем пустой виджет
              }
            }).toList(),
          ),
        ],
      ),
    );
  }
}