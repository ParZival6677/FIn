import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'AccountSelectionPage.dart';
import 'Theme_provider.dart';
import 'AppLocalizations.dart';
import 'CategorySelectionPage.dart';
import 'database.dart';

class AddOperationsPage extends StatefulWidget {
  @override
  _AddOperationsPageState createState() => _AddOperationsPageState();
}

class _AddOperationsPageState extends State<AddOperationsPage> with SingleTickerProviderStateMixin {
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  bool _detailsVisible = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  String _selectedCategory = '';
  String _selectedCategoryIconPath = 'assets/icons/nalichka.png';
  String _selectedDate = '';
  String _selectedAccount = '';
  String _selectedAccountIconPath = 'assets/icons/nalichka.png';
  String _transactionType = 'income';
  String? _selectedImagePath;
  String? _selectedPhotoPath;

  final List<Map<String, dynamic>> _incomeCategories = [
    {'header': 'Основные доходы'},
    {
      'category': 'Работа',
      'iconPath': 'assets/icons/cash.png',
    },
    {
      'category': 'Семья',
      'iconPath': 'assets/icons/family.png',
    },
    {
      'category': 'Стипендия',
      'iconPath': 'assets/icons/stipendia.png',
    },
    {
      'category': 'Другое',
      'iconPath': 'assets/icons/other.png',
    },
  ];

  final List<Map<String, dynamic>> _expenseCategories = [
    {'header': 'Регулярные расходы'},
    {
      'category': 'Питание',
      'iconPath': 'assets/icons/food.png',
    },
    {
      'category': 'Транспорт',
      'iconPath': 'assets/icons/car.png',
    },
    {
      'category': 'Арендная плата',
      'iconPath': 'assets/icons/arenda.png',
    },
    {
      'category': 'Аптеки',
      'iconPath': 'assets/icons/apteka.png',
    },
    {
      'category': 'Одежда',
      'iconPath': 'assets/icons/cloth.png',
    },
    {'header': 'Счета'},
    {
      'category': 'Счет за воду',
      'iconPath': 'assets/icons/water-bill.png',
    },
    {
      'category': 'Счет за телефон',
      'iconPath': 'assets/icons/phone-bill.png',
    },
    {
      'category': 'Счет за электричество',
      'iconPath': 'assets/icons/electricity-bill.png',
    },
    {
      'category': 'Счет за газ',
      'iconPath': 'assets/icons/gas-bill.png',
    },
    {
      'category': 'Счет за телевидение',
      'iconPath': 'assets/icons/tv-bill.png',
    },
    {
      'category': 'Счет за интернет',
      'iconPath': 'assets/icons/internet-bill.png',
    },
    {
      'category': 'Другие счета',
      'iconPath': 'assets/icons/other-bills.png',
    },
    {'header': 'Обслуживание'},
    {
      'category': 'Обслеживание транспорта',
      'iconPath': 'assets/icons/remont.png',
    },
    {
      'category': 'Медицина',
      'iconPath': 'assets/icons/medicine.png',
    },
    {
      'category': 'Страховки',
      'iconPath': 'assets/icons/strahovka.png',
    },
    {
      'category': 'Образование',
      'iconPath': 'assets/icons/education.png',
    },
    {
      'category': 'Домашние животные',
      'iconPath': 'assets/icons/pets.png',
    },
    {
      'category': 'Прочие рассходы',
      'iconPath': 'assets/icons/other.png',
    },
    {'header': 'Развлечения'},
    {
      'category': 'Подарки',
      'iconPath': 'assets/icons/gifts.png',
    },
    {
      'category': 'Игры',
      'iconPath': 'assets/icons/games.png',
    },
    {
      'category': 'Вредные привычки',
      'iconPath': 'assets/icons/bad-habits.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _selectedDate = DateFormat.yMMMMd().format(DateTime.now());
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _requestPermission() async {
    PermissionStatus status = await Permission.photos.request();
    if (status.isGranted) {
      _pickImage();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedPhotoPath = pickedFile.path;
      });
    }
  }

  void _toggleDetails() {
    if (_detailsVisible) {
      _animationController.reverse().then((_) {
        setState(() {
          _detailsVisible = !_detailsVisible;
        });
      });
    } else {
      setState(() {
        _detailsVisible = !_detailsVisible;
      });
      _animationController.forward();
    }
  }

  void _selectCategory() async {
    final categories = _transactionType == 'income' ? _incomeCategories : _expenseCategories;
    final selectedCategory = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategorySelectionPage(
          categories: categories,
          onCategorySelected: (category) {
            Navigator.pop(context, category);
          },
        ),
      ),
    );

    if (selectedCategory != null) {
      setState(() {
        _selectedCategory = selectedCategory;
        _selectedCategoryIconPath = categories.firstWhere(
              (cat) => cat['category'] == selectedCategory,
        )['iconPath'];
      });
    }
  }

  void _selectAccount() async {
    final selectedAccount = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountSelectionPage(
          onAccountSelected: (account) {
            Navigator.pop(context, account);
          },
        ),
      ),
    );

    if (selectedAccount != null) {
      setState(() {
        _selectedAccount = selectedAccount['category'];
        _selectedAccountIconPath = selectedAccount['iconPath'];
      });
    }
  }

  void _resetFields() {
    setState(() {
      _selectedCategory = '';
      _selectedCategoryIconPath = 'assets/icons/nalichka.png';
      _selectedAccount = '';
      _selectedAccountIconPath = 'assets/icons/nalichka.png';
      _amountController.clear();
      _descriptionController.clear();
      _selectedImagePath = null;
      _selectedPhotoPath = null;
    });
  }

  Future<void> _saveOperation() async {
    if (_amountController.text.isEmpty) {
      _showSnackbar('Please enter an amount', false);
      return;
    }

    double? amount = double.tryParse(_amountController.text);
    if (amount == null) {
      _showSnackbar('Invalid amount', false);
      return;
    }

    final dbHelper = DatabaseHelper();
    final data = {
      'amount': amount,
      'category': _selectedCategory,
      'categoryIconPath': _selectedCategoryIconPath,
      'date': _selectedDate,
      'account': _selectedAccount,
      'accountIconPath': _selectedAccountIconPath,
      'description': _descriptionController.text.isNotEmpty ? _descriptionController.text : null,
      'imagePath': _selectedImagePath,
      'photoPath': _selectedPhotoPath,
    };

    try {
      final accountBalance = await dbHelper.getAccountBalance(_selectedAccount);
      if (_transactionType == 'expense' && amount > accountBalance) {
        _showSnackbar('Insufficient funds', false);
        return;
      }

      if (_transactionType == 'income') {
        await dbHelper.insertIncome(data);
        await dbHelper.updateAccountBalance(_selectedAccount, amount, true);
      } else {
        await dbHelper.insertExpense(data);
        await dbHelper.updateAccountBalance(_selectedAccount, amount, false);
      }
      _showSnackbar('Operation saved successfully', true);
    } catch (e) {
      _showSnackbar('Failed to save operation: $e', false);
    }

    // Reset the fields after saving
    _resetFields();
  }

  void _showSnackbar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.customTheme == 'dark';
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.addOperation ?? 'Добавить операцию'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Income/Expense Tabs
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: DefaultTabController(
              length: 2,
              child: TabBar(
                labelColor: Color(0xFF10B981),
                unselectedLabelColor: Theme.of(context).textTheme.bodyLarge?.color,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xFF10B981), width: 4),
                  insets: EdgeInsets.symmetric(horizontal: 130.0),
                ),
                tabs: [
                  Tab(text: localizations?.income ?? 'Доход'),
                  Tab(text: localizations?.expense ?? 'Расход'),
                ],
                onTap: (index) {
                  _resetFields(); // Reset fields when switching tabs
                  setState(() {
                    _transactionType = index == 0 ? 'income' : 'expense';
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  _buildInputField(
                    context,
                    iconPath: isDarkMode
                        ? 'assets/icons/cash-outline-dark-theme.png'
                        : 'assets/icons/cash-outline.png',
                    hintText: localizations?.enterAmount ?? 'Введите сумму',
                    controller: _amountController,
                  ),
                  GestureDetector(
                    onTap: _selectCategory,
                    child: _buildStaticField(
                      context,
                      iconPath: _selectedCategory.isEmpty
                          ? (isDarkMode
                          ? 'assets/icons/pricetags-outline-dark-theme.png'
                          : 'assets/icons/pricetags-outline.png')
                          : _selectedCategoryIconPath,
                      valueText: _selectedCategory.isEmpty
                          ? localizations?.chooseCategory ?? 'Выберите категорию'
                          : localizations?.translate(_selectedCategory) ?? _selectedCategory,
                    ),
                  ),
                  _buildStaticField(
                    context,
                    iconPath: isDarkMode
                        ? 'assets/icons/Calendar-dark-theme.png'
                        : 'assets/icons/Calendar.png',
                    valueText: _selectedDate,
                  ),
                  GestureDetector(
                    onTap: _selectAccount,
                    child: _buildStaticField(
                      context,
                      iconPath: _selectedAccount.isEmpty
                          ? (isDarkMode
                          ? 'assets/icons/nalichka.png'
                          : 'assets/icons/nalichka.png')
                          : _selectedAccountIconPath,
                      valueText: _selectedAccount.isEmpty
                          ? localizations?.chooseAccount ?? 'Выберите счет'
                          : _selectedAccount,
                    ),
                  ),
                  _detailsVisible
                      ? SizeTransition(
                    sizeFactor: _animation,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        _buildInputField(
                          context,
                          iconPath: isDarkMode
                              ? 'assets/icons/document-text-outline-dark-theme.png'
                              : 'assets/icons/document-text-outline.png',
                          hintText: localizations?.enterDescription ?? 'Введите описание',
                          controller: _descriptionController,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.photo_library),
                                    onPressed: _requestPermission,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.camera_alt),
                                    onPressed: _takePhoto,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                          child: GestureDetector(
                            onTap: _toggleDetails,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  localizations?.hideDetails ?? 'Скрыть детали',
                                  style: TextStyle(
                                    color: Color(0xFF10B981),
                                    fontSize: 16.0,
                                  ),
                                ),
                                Icon(
                                  _detailsVisible ? Icons.expand_less : Icons.expand_more,
                                  color: Color(0xFF10B981),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: GestureDetector(
                      onTap: _toggleDetails,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localizations?.addDetails ?? 'Добавить детали',
                            style: TextStyle(
                              color: Color(0xFF10B981),
                              fontSize: 16.0,
                            ),
                          ),
                          Icon(
                            _detailsVisible ? Icons.expand_less : Icons.expand_more,
                            color: Color(0xFF10B981),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveOperation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF10B981),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    localizations?.add ?? 'Добавить',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
      BuildContext context, {
        required String iconPath,
        required String hintText,
        required TextEditingController controller,
      }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 32.0,
              height: 32.0,
              scale: 0.8,
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: theme.hintColor,
                    fontSize: 18.0,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.dividerColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.dividerColor),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 18.0, color: theme.textTheme.bodyLarge?.color),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticField(
      BuildContext context, {
        required String iconPath,
        required String valueText,
      }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 32.0,
              height: 32.0,
              scale: 0.8,
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Text(
                valueText,
                style: TextStyle(fontSize: 18.0, color: theme.textTheme.bodyLarge?.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
