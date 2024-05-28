import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database.dart';
import 'Theme_provider.dart';
import 'AppLocalizations.dart';

class SavingsPage extends StatefulWidget {
  @override
  _SavingsPageState createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  late TextEditingController _amountController;
  late TextEditingController _categoryController;
  late DatabaseHelper _databaseHelper;

  final List<String> categoryIconPaths = [
    'assets/icons/fin-pod.png',
    'assets/icons/Thumbnail.png',
    'assets/icons/cash.png',
  ];

  String _selectedIconPath = 'assets/icons/fin-pod.png';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final isDarkMode = themeProvider.isDarkMode;
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations!.addSaving,
          style: TextStyle(fontSize: 24.0),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
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
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Image.asset(
                    isDarkMode ? 'assets/icons/cash-outline-dark-theme.png' : 'assets/icons/cash-outline.png',
                    width: 32.0,
                    height: 32.0,
                    scale: 0.8,
                  ),
                  SizedBox(height: 80, width: 20.0),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        hintText: localizations.enterAmount,
                        hintStyle: TextStyle(
                          color: theme.textTheme.bodyLarge?.color,
                          fontSize: 18.0,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: theme.textTheme.bodyLarge?.color ?? Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: theme.textTheme.bodyLarge?.color ?? Colors.black),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 18.0, color: theme.textTheme.bodyLarge?.color),
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
                color: theme.cardColor,
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
                        hintText: localizations.enterCategory,
                        hintStyle: TextStyle(
                          color: theme.textTheme.bodyLarge?.color,
                          fontSize: 18.0,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: theme.textTheme.bodyLarge?.color ?? Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: theme.textTheme.bodyLarge?.color ?? Colors.black),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(fontSize: 18.0, color: theme.textTheme.bodyLarge?.color),
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
                        _addToSavings();
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
                          localizations.add,
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

  void _selectIcon() {
    final localizations = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizations!.chooseIcon),
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

  void _addToSavings() async {
    final localizations = AppLocalizations.of(context);
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    String category = _categoryController.text.trim();

    if (amount > 0) {
      bool categoryExists = await _databaseHelper.checkCategoryExists(category);

      if (categoryExists) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(localizations!.warning),
              content: Text(localizations.categoryExists.replaceAll('{category}', category)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _databaseHelper.insertSavings(amount, category, _selectedIconPath);
                    _amountController.clear();
                    _categoryController.clear();
                  },
                  child: Text(localizations.yes),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(localizations.cancel),
                ),
              ],
            );
          },
        );
      } else {
        await _databaseHelper.insertSavings(amount, category, _selectedIconPath);

        _amountController.clear();
        _categoryController.clear();
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(localizations!.error),
            content: Text(localizations.invalidAmount),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(localizations.ok),
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
