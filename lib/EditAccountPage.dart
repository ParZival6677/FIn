import 'package:flutter/material.dart';
import 'database.dart';

class EditAccountPage extends StatefulWidget {
  final Map<String, dynamic> accountData;

  EditAccountPage({required this.accountData});

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  late TextEditingController _amountController;
  late TextEditingController _categoryController;
  late String _iconPath = '';
  bool _excludeNotifications = false;
  bool _excludeFromTotal = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.accountData['amount'].toString());
    _categoryController = TextEditingController(text: widget.accountData['category']);
    _iconPath = widget.accountData['iconPath'] ?? 'assets/icons/cash-outline.png';
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }


  Future<void> _saveChanges(BuildContext context) async {
    double amount = double.parse(_amountController.text);
    String category = _categoryController.text;
    String iconPath = _iconPath;
    int id = widget.accountData['id'];

    if (_amountController.text != widget.accountData['amount'].toString() ||
        _categoryController.text != widget.accountData['category']) {
      if (_categoryController.text != widget.accountData['category']) {
        int updateCategoryResult = await DatabaseHelper()
            .updateAccountsCategoryName(widget.accountData['category'], _categoryController.text);
        if (updateCategoryResult > 0) {
          print('Category name updated successfully');
        } else {
          print('Failed to update category name');
        }
      }

      int updateAmountResult = await DatabaseHelper().updateAccounts(id, amount, iconPath);
      if (updateAmountResult > 0) {
        print('Amount updated successfully');

        final snackBar = SnackBar(
          content: Text('Changes saved successfully'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        print('Failed to update amount');
      }
    } else {
      final snackBar = SnackBar(
        content: Text('No changes to save'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Navigator.of(context).pop();
  }


  Future<void> _deleteAccount(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Подтвердите удаление'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Вы уверены, что хотите удалить этот счет?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Удалить'),
              onPressed: () async {
                Navigator.of(context).pop();
                int id = widget.accountData['id'];
                int result = await DatabaseHelper().deleteAccounts(id);
                final snackBar = SnackBar(
                  content: Text(result > 0 ? 'Счет успешно удален' : 'Не удалось удалить счет'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать счет'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                _saveChanges(context);
              },
              icon: Image.asset(
                'assets/icons/save-button.png',
              ),
              iconSize: 40,
            ),
          ),
        ],
      ),
      body: ListView(
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
                  Image.asset(
                    _iconPath.isNotEmpty ? _iconPath : 'assets/icons/cash-outline.png',
                    width: 32.0,
                    height: 32.0,
                    scale: 0.8,
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
          SizedBox(height: 20,),
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
                right: 30,
                child: IconButton(
                  icon: Image.asset(
                    _excludeNotifications
                        ? 'assets/icons/switch-enabled.png'
                        : 'assets/icons/switch-disabled.png',
                    width: 60.0,
                    height: 60.0,
                    scale: 0.7,
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
                right: 30,
                child: IconButton(
                  icon: Image.asset(
                    _excludeFromTotal
                        ? 'assets/icons/switch-enabled.png'
                        : 'assets/icons/switch-disabled.png',
                    width: 60.0,
                    height: 60.0,
                    scale: 0.7,
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
          SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () {
                _deleteAccount(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/trash-red-outline.png',
                    width: 32.0,
                    height: 32.0,
                    scale: 0.9,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Удалить счет',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}