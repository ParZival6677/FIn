import 'package:flutter/material.dart';
import 'PlanningPage.dart';
import 'Notifications.dart';
import 'ProfilePage.dart';
import 'SavingsPage.dart';
import 'LoansPage.dart';
import 'database.dart';
import 'CategoryDetailPage.dart';
import 'LoansDetailPage.dart';
import 'AccountsPage.dart';
import 'EditAccountPage.dart';
import 'package:provider/provider.dart';
import 'Theme_provider.dart';
import 'Settings.dart';
import 'AppLocalizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Personal Finance Management',
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              primaryColor: Color(0xFF10B981),
              scaffoldBackgroundColor: Color(0xFFF2F2F2),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: AppBarTheme(
                backgroundColor: Color(0xFFe0e0e0),
                foregroundColor: Colors.black,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black54,
              ),
            ),
            darkTheme: ThemeData(
              primaryColor: Color(0xFF10B981),
              scaffoldBackgroundColor: Colors.black,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              colorScheme: ColorScheme.dark(),
              appBarTheme: AppBarTheme(
                backgroundColor: Color(0xFF424242),
                foregroundColor: Colors.white,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Color(0xFF424242),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white70,
              ),
            ),
            locale: _locale,
            supportedLocales: [
              Locale('en', ''),
              Locale('ru', ''),
              Locale('kk', ''),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale == null) return supportedLocales.first;
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            home: HomePage(),
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isSavingsExpanded = false;
  bool _isLoansExpanded = false;
  bool _isBalanceVisible = true;

  num _totalBalance = 0;

  List<Map<String, dynamic>> _savingsList = [];
  List<Map<String, dynamic>> _loansList = [];
  List<Map<String, dynamic>> _accountsList = [];
  late Map<String, String> _savingsCategoryIconMap = {};
  late Map<String, String> _loansCategoryIconMap = {};
  Map<String, num> _savingsCategorySumMap = {};
  Map<String, num> _loansCategorySumMap = {};

  @override
  void initState() {
    super.initState();
    _updateSavingsList();
    _updateLoansList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSavingsList();
    _updateLoansList();
    _updateAccountsList();
  }

  void _updateSavingsList() async {
    List<Map<String, dynamic>> savings = await DatabaseHelper().getSavings();

    Map<String, num> categorySumMap = {};
    num total = 0;

    for (var saving in savings) {
      String category = saving['category'];
      num amount = saving['amount'];
      String iconPath = saving['iconPath'];
      categorySumMap[category] = (categorySumMap[category] ?? 0) + amount;
      total += saving['amount'];
      _savingsCategoryIconMap[category] = iconPath;
    }

    setState(() {
      _totalBalance = total;
      _savingsList = savings;
      _savingsCategorySumMap = categorySumMap;
      _savingsCategoryIconMap = {};
    });
  }

  void _updateLoansList() async {
    List<Map<String, dynamic>> loans = await DatabaseHelper().getLoans();

    Map<String, num> categorySumMap = {};

    for (var loan in loans) {
      String category = loan['category'];
      num amount = loan['amount'];
      String iconPath = loan['iconPath'];
      categorySumMap[category] = (categorySumMap[category] ?? 0) + amount;
      _loansCategoryIconMap[category] = iconPath;
    }

    setState(() {
      _loansList = loans;
      _loansCategorySumMap = categorySumMap;
      _loansCategoryIconMap = {};
    });
  }

  void _updateAccountsList() async {
    List<Map<String, dynamic>> accounts = await DatabaseHelper().getAccounts();
    setState(() {
      _accountsList = accounts;
    });
  }

  Future<Map<String, dynamic>> _getCategoryDataSavings(String category) async {
    try {
      String iconPath = await DatabaseHelper().getCategoryIconsSavings(category);
      return {'iconPath': iconPath};
    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, dynamic>> _getCategoryDataLoans(String category) async {
    try {
      String iconPath = await DatabaseHelper().getCategoryIconsLoans(category);
      return {'iconPath': iconPath};
    } catch (error) {
      throw error;
    }
  }

  num _calculateTotalBalance() {
    num total = 0;

    for (var account in _accountsList) {
      total += account['amount'];
    }

    for (var amount in _savingsCategorySumMap.values) {
      total += amount;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final localizations = AppLocalizations.of(context)!;

    _totalBalance = _calculateTotalBalance();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        _isBalanceVisible ? '${_totalBalance.toString()} \u20B8' : '*******', // Show *** if balance is hidden
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 30.0,
                        ),
                      ),
                      SizedBox(width: 5),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isBalanceVisible = !_isBalanceVisible;
                          });
                        },
                        icon: Image.asset(
                          _isBalanceVisible
                              ? (isDarkMode ? 'assets/icons/eye-dark-theme.png' : 'assets/icons/eye.png')
                              : (isDarkMode ? 'assets/icons/eye-off-dark-theme.png' : 'assets/icons/eye-off.png'),
                          width: 32.0,
                          height: 32.0,
                          scale: 0.9,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    localizations.totalBalance,
                    style: TextStyle(
                      color: Color(0xFF7F7F7F),
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationsPage()),
                  );
                },
                icon: Container(
                  margin: EdgeInsets.only(bottom: 25),
                  child: Image.asset(
                    isDarkMode
                        ? 'assets/icons/notifications-dark-theme.png'
                        : 'assets/icons/notifications.png',
                    width: 32.0,
                    height: 32.0,
                    scale: 0.9,
                  ),
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                localizations.myAccounts,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AccountsPage()),
                                  );
                                },
                                child: Text(
                                  localizations.viewAll,
                                  style: TextStyle(
                                    color: Color(0xFF10B981),
                                    fontSize: 17,
                                  ),
                                ),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(109, 20)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Divider(
                            color: Theme.of(context).dividerColor,
                            thickness: 2.0,
                          ),
                          for (var account in _accountsList)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditAccountPage(accountData: account)),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 36.0,
                                          child: Image.asset(
                                            account['iconPath'] ?? 'assets/icons/Thumbnail.png',
                                            width: 40.0,
                                            height: 40.0,
                                            scale: 0.7,
                                          ),
                                        ),
                                        SizedBox(width: 15.0),
                                        Text(
                                          account['category'] ?? '',
                                          style: TextStyle(
                                            color: Theme.of(context).textTheme.bodyLarge?.color,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${account['amount']} \u20B8',
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.bodyLarge?.color,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                localizations.analytics,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  localizations.details,
                                  style: TextStyle(
                                    color: Color(0xFF10B981),
                                    fontSize: 17,
                                  ),
                                ),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(109, 20)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: Center(
                                child: Container(
                                  width: 85.0,
                                  height: 85.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).cardColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildExpandableContainer(
            title: localizations.savings,
            iconPath: '',
            isExpanded: _isSavingsExpanded,
            onPressed: () {
              setState(() {
                _isSavingsExpanded = !_isSavingsExpanded;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                for (var category in _savingsCategorySumMap.keys)
                  FutureBuilder(
                    future: _getCategoryDataSavings(category),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        String iconPath = snapshot.data?['iconPath'] ?? 'assets/icons/Thumbnail.png';
                        return Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CategoryDetailPage(categoryName: category)),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 36.0,
                                        child: Image.asset(
                                          iconPath,
                                          width: 40.0,
                                          height: 40.0,
                                          scale: 0.7,
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        '${category}',
                                        style: TextStyle(
                                          color: Theme.of(context).textTheme.bodyLarge?.color,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _savingsCategorySumMap[category] != null && _savingsCategorySumMap[category]! > 0
                                        ? '+ ${_savingsCategorySumMap[category]} \u20B8'
                                        : '${_savingsCategorySumMap[category] ?? 0} \u20B8',
                                    style: TextStyle(
                                      color: _savingsCategorySumMap[category] != null && _savingsCategorySumMap[category]! > 0
                                          ? Color(0xFF10B981)
                                          : Theme.of(context).textTheme.bodyLarge?.color,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SavingsPage()),
                    );
                  },
                  child: Text(
                    localizations.addSavings,
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,
                    elevation: 0,
                    minimumSize: Size(200, 30),
                    textStyle: TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildExpandableContainer(
            title: localizations.loans,
            iconPath: '',
            isExpanded: _isLoansExpanded,
            onPressed: () {
              setState(() {
                _isLoansExpanded = !_isLoansExpanded;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                for (var category in _loansCategorySumMap.keys)
                  FutureBuilder(
                    future: _getCategoryDataLoans(category),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        String iconPath = snapshot.data?['iconPath'] ?? 'assets/icons/Thumbnail.png';
                        return Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoansDetailPage(categoryName: category)),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 36.0,
                                        child: Image.asset(
                                          iconPath,
                                          width: 40.0,
                                          height: 40.0,
                                          scale: 0.7,
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        '${category}',
                                        style: TextStyle(
                                          color: Theme.of(context).textTheme.bodyLarge?.color,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _loansCategorySumMap[category] != null && _loansCategorySumMap[category]! > 0
                                        ? '- ${_loansCategorySumMap[category]} \u20B8'
                                        : '${_loansCategorySumMap[category] ?? 0} \u20B8',
                                    style: TextStyle(
                                      color: _loansCategorySumMap[category] != null && _loansCategorySumMap[category]! > 0
                                          ? Color(0xFFB3261E)
                                          : Theme.of(context).textTheme.bodyLarge?.color,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoansPage()),
                    );
                  },
                  child: Text(
                    localizations.addLoans,
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,
                    elevation: 0,
                    minimumSize: Size(200, 30),
                    textStyle: TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
        ],
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
                break;
              case 1:
              // Navigate to Operations Page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => OperationsPage()),
              // );
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
        unselectedItemColor: isDarkMode ? Colors.white70 : Colors.black,
        selectedLabelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        unselectedLabelStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
        backgroundColor: Theme.of(context).cardColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              isDarkMode
                  ? (_selectedIndex == 0
                  ? 'assets/icons/active-home.png'
                  : 'assets/icons/home-outline-dark-theme.png')
                  : (_selectedIndex == 0
                  ? 'assets/icons/active-home.png'
                  : 'assets/icons/home.png'),
              width: 60.0,
              height: 60.0,
              scale: 0.8,
            ),
            label: localizations.main,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              isDarkMode
                  ? (_selectedIndex == 1
                  ? 'assets/icons/active-wallet.png'
                  : 'assets/icons/wallet-outline-dark-theme.png')
                  : (_selectedIndex == 1
                  ? 'assets/icons/active-wallet.png'
                  : 'assets/icons/wallet.png'),
              width: 60.0,
              height: 60.0,
              scale: 0.8,
            ),
            label: localizations.operations,
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
            icon: Image.asset(
              isDarkMode
                  ? (_selectedIndex == 3
                  ? 'assets/icons/active-clipboard.png'
                  : 'assets/icons/clipboard-outline-dark-theme.png')
                  : (_selectedIndex == 3
                  ? 'assets/icons/active-clipboard.png'
                  : 'assets/icons/clipboard.png'),
              width: 60.0,
              height: 60.0,
              scale: 0.8,
            ),
            label: localizations.plans,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              isDarkMode
                  ? (_selectedIndex == 4
                  ? 'assets/icons/active-person.png'
                  : 'assets/icons/person-outline-dark-theme.png')
                  : (_selectedIndex == 4
                  ? 'assets/icons/active-person.png'
                  : 'assets/icons/person.png'),
              width: 60.0,
              height: 60.0,
              scale: 0.8,
            ),
            label: localizations.profilepage,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableContainer({
    required String title,
    required String iconPath,
    required bool isExpanded,
    required VoidCallback onPressed,
    required Widget child,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: onPressed,
                          icon: Image.asset(
                            isExpanded
                                ? (isDarkMode ? 'assets/icons/caret-up-outline-dark-theme.png' : 'assets/icons/caret-up-outline.png')
                                : (isDarkMode ? 'assets/icons/caret-down-dark-theme.png' : 'assets/icons/caret-down.png'),
                            width: 24.0,
                            height: 24.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Divider(
                      color: Theme.of(context).dividerColor,
                      thickness: 2.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: isExpanded ? null : 0,
            child: isExpanded ? child : null,
          ),
        ],
      ),
    );
  }
}
