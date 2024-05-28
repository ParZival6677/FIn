import 'package:flutter/material.dart';
import 'database.dart';
import 'LoansPage.dart';

class LoansDetailPage extends StatelessWidget {
  final String categoryName;

  LoansDetailPage({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: TextStyle(fontSize: 24.0),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _confirmDeleteCategory(context);
            },
            icon: Container(
              margin: EdgeInsets.only(right: 18),
              child: Image.asset(
                'assets/icons/trash-outline.png',
                width: 26.0,
                height: 26.0,
                scale: 0.9,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GestureDetector(
              onTap: () {
                _showSumEditDialog(context);
              },
              child: FutureBuilder(
                future: _getCategoryData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    var categoryData = snapshot.data as Map<String, dynamic>?;
                    if (categoryData == null) {
                      return Text('No data available');
                    }
                    double? currentSum = categoryData['currentSum'];
                    if (currentSum == null) {
                      return Text('No sum available');
                    }
                    return Container(
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
                            scale: 0.9,
                          ),
                          SizedBox(height: 80, width: 20.0),
                          Text(
                            '$currentSum \u20B8',
                            style: TextStyle(
                              color: Color(0xFF7F7F7F),
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GestureDetector(
              onTap: () {
                _showCategoryEditDialog(context);
              },
              child: FutureBuilder(
                future: _getCategoryData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    var categoryData = snapshot.data as Map<String, dynamic>?;
                    if (categoryData == null) {
                      return Text('No data available');
                    }
                    double? currentSum = categoryData['currentSum'];
                    if (currentSum == null) {
                      return Text('No sum available');
                    }
                    String? iconPath = categoryData['iconPath'];
                    if (iconPath == null) {
                      return Text('No icon path available');
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            iconPath,
                            width: 36.0,
                            height: 36.0,
                            scale: 0.5,
                          ),
                          SizedBox(height: 80, width: 20.0),
                          Text(
                            categoryName,
                            style: TextStyle(
                              color: Color(0xFF7F7F7F),
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoansPage()),
                );
              },
              child: Text(
                '+   Пополнить',
                style: TextStyle(
                  color: Color(0xFF10B981),
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> _getCategoryData() async {
    try {
      String? iconPath = await DatabaseHelper().getCategoryIconsLoans(categoryName);
      double currentSum = await _getCategorySum();
      return {'iconPath': iconPath, 'currentSum': currentSum};
    } catch (error) {
      throw error;
    }
  }

  Future<double> _getCategorySum() async {
    try {
      List<Map<String, dynamic>> savings = await DatabaseHelper().getLoans();
      double sum = 0;
      for (var saving in savings) {
        if (saving['category'] == categoryName) {
          sum += saving['amount'];
        }
      }
      return sum;
    } catch (error) {
      throw error;
    }
  }

  void _confirmDeleteCategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Подтвердите удаление"),
          content: Text("Вы уверены, что хотите удалить категорию \"$categoryName\"?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Отмена"),
            ),
            TextButton(
              onPressed: () {
                _deleteCategory(context);
              },
              child: Text("Удалить"),
            ),
          ],
        );
      },
    );
  }

  void _deleteCategory(BuildContext context) async {
    try {
      List<int> categoryIds = await DatabaseHelper().findCategoryIdsByNameLoans(categoryName);

      for (int categoryId in categoryIds) {
        int rowsAffected = await DatabaseHelper().deleteLoans(categoryId);
        if (rowsAffected <= 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Ошибка"),
                content: Text("Не удалось удалить одну или несколько категорий. Попробуйте снова."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
          return;
        }
      }

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } catch (error) {
      print("Ошибка при удалении категорий: $error");
    }
  }
  void _showSumEditDialog(BuildContext context) {
    double newSum = 0.0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Редактирование"),
          content: TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              newSum = double.tryParse(value) ?? 0.0;
            },
            decoration: InputDecoration(hintText: "Введите сумму"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Отмена"),
            ),
            TextButton(
              onPressed: () {
                _saveNewSum(newSum);
                Navigator.of(context).pop();
              },
              child: Text("Сохранить"),
            ),
          ],
        );
      },
    );
  }

  void _showCategoryEditDialog(BuildContext context) {
    String newCategoryName = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Редактирование"),
          content: TextField(
            onChanged: (value) {
              newCategoryName = value;
            },
            decoration: InputDecoration(hintText: "Введите категорию"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Отмена"),
            ),
            TextButton(
              onPressed: () {
                _saveNewCategoryName(newCategoryName);
                Navigator.of(context).pop();
              },
              child: Text("Сохранить"),
            ),
          ],
        );
      },
    );
  }

  void _saveNewSum(double newSum) async {
    try {
      await DatabaseHelper().updateLoansSum(categoryName, newSum);
    } catch (error) {
      print('Ошибка при сохранении новой суммы: $error');
    }
  }



  void _saveNewCategoryName(String newCategoryName) async {
    try {
      await DatabaseHelper().updateCategoryNameLoans(categoryName, newCategoryName);
    } catch (error) {
      print('Ошибка при сохранении нового имени категории: $error');
    }
  }
}