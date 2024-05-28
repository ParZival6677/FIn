import 'package:flutter/material.dart';
import 'database.dart';

class AddAccountPage extends StatefulWidget {
  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  late TextEditingController _amountController;
  late TextEditingController _categoryController;
  String _selectedIconPath = '';
  bool _excludeNotifications = false;
  bool _excludeFromTotal = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _categoryController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить счет'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/cash-outline.png',
                      width: 32.0,
                      height: 32.0,
                      scale: 0.8,
                    ),
                    SizedBox(height: 80, width: 20.0),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          hintText: 'Введите сумму',
                          hintStyle: TextStyle(
                            color: Color(0xFF7F7F7F),
                            fontSize: 18.0,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: _showIconSelectionDialog,
                      child: Image.asset(
                        _selectedIconPath.isEmpty ? 'assets/icons/Thumbnail.png' : _selectedIconPath,
                        width: 32.0,
                        height: 32.0,
                        scale: 0.8,
                      ),
                    ),
                    SizedBox(height: 80, width: 20.0),
                    Expanded(
                      child: TextFormField(
                        controller: _categoryController,
                        decoration: InputDecoration(
                          hintText: 'Введите категорию',
                          hintStyle: TextStyle(
                            color: Color(0xFF7F7F7F),
                            fontSize: 18.0,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 120, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Включить уведомления',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Получить уведомление, когда будут изменения в операциях этого кошелька',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF7F7F7F),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 18,
                  child: IconButton(
                    icon: Image.asset(
                      _excludeNotifications
                          ? 'assets/icons/switch-enabled.png'
                          : 'assets/icons/switch-disabled.png',
                      width: 50.0,
                      height: 50.0,
                      scale: 0.9,
                    ),
                    onPressed: () {
                      setState(() {
                        _excludeNotifications = !_excludeNotifications;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 130, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Исключить с Итого',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Игнорировать этот кошелек и его ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF7F7F7F),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'баланс в режиме «Итого»',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF7F7F7F),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 18,
                  child: IconButton(
                    icon: Image.asset(
                      _excludeFromTotal
                          ? 'assets/icons/switch-enabled.png'
                          : 'assets/icons/switch-disabled.png',
                      width: 50.0,
                      height: 50.0,
                      scale: 0.4,
                    ),
                    onPressed: () {
                      setState(() {
                        _excludeFromTotal = !_excludeFromTotal;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 210),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _saveAccount();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF10B981)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Добавить',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showIconSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Выберите иконку категории'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconSelectionItem('assets/icons/Thumbnail.png'),
              _buildIconSelectionItem('assets/icons/kaspi-logo.png'),
              _buildIconSelectionItem('assets/icons/halyk_logo.png'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconSelectionItem(String iconPath) {
    return ListTile(
      onTap: () {
        setState(() {
          _selectedIconPath = iconPath;
        });
        Navigator.of(context).pop();
      },
      leading: Image.asset(
        iconPath,
        width: 40.0,
        height: 40.0,
      ),
    );
  }

  void _saveAccount() async {
    final double amount = double.tryParse(_amountController.text) ?? 0.0;
    final String category = _categoryController.text.trim();

    bool categoryExists = await DatabaseHelper().checkAccountsCategoryExists(category);

    if (amount > 0 && category.isNotEmpty && _selectedIconPath.isNotEmpty) {
      if (categoryExists) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Предупреждение'),
              content: Text('Категория "$category" уже существует. Вы уверены, что хотите добавить запись?'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    double existingAmount = await DatabaseHelper().getAccountsCategorySum(category);
                    double newAmount = existingAmount + amount;
                    await DatabaseHelper().updateAccountsSum(category, newAmount);
                    Navigator.of(context).pop();
                  },
                  child: Text('Да'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Отмена'),
                ),
              ],
            );
          },
        );
      } else {
        DatabaseHelper().insertAccounts(amount, category, _selectedIconPath);
        Navigator.of(context).pop();
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ошибка'),
            content: Text('Пожалуйста, введите корректные данные.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}