import 'package:flutter/material.dart';
import 'database.dart';


class LoansPage extends StatefulWidget {
  @override
  _LoansPageState createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  late TextEditingController _amountController;
  late TextEditingController _categoryController;
  late DatabaseHelper _databaseHelper;


  final List<String> categoryIconPaths = [
    'assets/icons/Thumbnail.png',
    'assets/icons/cash.png',
    'assets/icons/arenda.png',
    'assets/icons/education.png',
    'assets/icons/gifts.png',
    'assets/icons/medicine.png',
    'assets/icons/remont.png',
    'assets/icons/strahovka.png'
  ];

  String _selectedIconPath = 'assets/icons/cash.png';

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _categoryController = TextEditingController();
    _databaseHelper = DatabaseHelper();
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
        title: Text(
          'Добавить кредит',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      body: Column(
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
                    onTap: _selectIcon,
                    child: Image.asset(
                      _selectedIconPath,
                      width: 34.0,
                      height: 36.0,
                      scale: 0.6,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _addToLoans();
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
          ),
        ],
      ),
    );
  }

  // Метод для выбора иконки из списка
  void _selectIcon() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Выберите иконку'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryIconPaths.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      _selectedIconPath = categoryIconPaths[index];
                    });
                    Navigator.pop(context);
                  },
                  leading: Image.asset(
                    categoryIconPaths[index],
                    scale: 0.6,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _addToLoans() async {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    String category = _categoryController.text.trim();

    if (amount > 0) {
      bool categoryExists = await _databaseHelper.checkLoansCategoryExists(category);

      if (categoryExists) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Предупреждение'),
              content: Text('Категория "$category" уже существует. Вы уверены, что хотите добавить запись?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _databaseHelper.insertLoans(amount, category, _selectedIconPath);
                    _amountController.clear();
                    _categoryController.clear();
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
        await _databaseHelper.insertLoans(amount, category, _selectedIconPath);


        _amountController.clear();
        _categoryController.clear();
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ошибка'),
            content: Text('Введенная сумма неверна. Пожалуйста, введите положительное число.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ОК'),
              ),
            ],
          );
        },
      );

      _amountController.clear();
      _categoryController.clear();
    }
  }
}