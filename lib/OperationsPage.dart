import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'AccountsPage.dart';
import 'database.dart';
import 'Theme_provider.dart';
import 'AppLocalizations.dart';
import 'AddOperationsPage.dart';
import 'PlanningPage.dart';
import 'ProfilePage.dart';
import 'main.dart';

class OperationsPage extends StatefulWidget {
  @override
  _OperationsPageState createState() => _OperationsPageState();
}

class _OperationsPageState extends State<OperationsPage> with SingleTickerProviderStateMixin {
  late Future<List<Map<String, dynamic>>> _transactionsFuture;
  double _balance = 0.0;
  int _selectedIndex = 1;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _loadTransactions();
    _calculateBalance();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<List<Map<String, dynamic>>> _loadTransactions() async {
    final dbHelper = DatabaseHelper();
    final incomes = await dbHelper.getAllIncomes();
    final expenses = await dbHelper.getAllExpenses();
    final transactions = [
      ...incomes.map((transaction) => {...transaction, 'type': 'income'}),
      ...expenses.map((transaction) => {...transaction, 'type': 'expense'}),
    ];
    transactions.sort((a, b) => _parseDate(b['date']).compareTo(_parseDate(a['date'])));
    return transactions;
  }

  Future<void> _calculateBalance() async {
    final dbHelper = DatabaseHelper();
    final accounts = await dbHelper.getAllAccounts();
    setState(() {
      _balance = accounts.fold(0.0, (sum, account) => sum + (account['amount'] as double));
    });
  }

  DateTime _parseDate(String dateString) {
    try {
      return DateFormat.yMMMMd().parse(dateString);
    } catch (e) {
      return DateTime.parse(dateString);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
          break;
        case 1:
        // Current page
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddOperationsPage()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlanningPage()),
          );
          break;
        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localizations = AppLocalizations.of(context);
    final isDarkMode = themeProvider.customTheme == 'dark';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: _buildBalanceSummary(context),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Color(0xFF10B981),
          unselectedLabelColor: Theme.of(context).textTheme.bodyLarge?.color,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Color(0xFF10B981), width: 4),
            insets: EdgeInsets.symmetric(horizontal: 175.0),
          ),
          labelStyle: TextStyle(fontSize: 16),
          unselectedLabelStyle: TextStyle(fontSize: 16),
          tabs: [
            Tab(text: localizations?.thisMonth ?? 'В ЭТОМ МЕСЯЦЕ'),
            Tab(text: localizations?.lastMonth ?? 'В ПРОШЛОМ МЕСЯЦЕ'),
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(localizations?.noTransactions ?? 'Нет транзакций'));
          }
          final transactions = snapshot.data!;
          final thisMonthTransactions = transactions.where((transaction) {
            final date = _parseDate(transaction['date']);
            final now = DateTime.now();
            return date.year == now.year && date.month == now.month;
          }).toList();
          final lastMonthTransactions = transactions.where((transaction) {
            final date = _parseDate(transaction['date']);
            final now = DateTime.now();
            return date.isBefore(DateTime(now.year, now.month, 1));
          }).toList();
          return TabBarView(
            controller: _tabController,
            children: [
              _buildTransactionList(context, thisMonthTransactions),
              _buildTransactionList(context, lastMonthTransactions),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
            label: localizations?.main,
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
            label: localizations?.operations,
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 72.0,
              height: 72.0,
              child: Transform.translate(
                offset: Offset(0.0, 8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddOperationsPage()),
                    );
                  },
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
            label: localizations?.plans,
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
            label: localizations?.profilepage,
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceSummary(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              localizations?.balance ?? 'Остаток',
              style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
            Text(
              '${NumberFormat.currency(symbol: '₸').format(_balance)}',
              style: TextStyle(fontSize: 24, color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
          ],
        ),
        TextButton.icon(
          icon: Image.asset('assets/icons/totals.png', width: 32.0, height: 32.0),
          label: Text(
            localizations?.totals ?? 'Итого',
            style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
          onPressed: () {
            // Add navigation to the desired page here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountsPage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTransactionList(BuildContext context, List<Map<String, dynamic>> transactions) {
    final groupedTransactions = _groupTransactionsByDate(transactions);
    return ListView.builder(
      itemCount: groupedTransactions.keys.length,
      itemBuilder: (context, index) {
        final date = groupedTransactions.keys.elementAt(index);
        final transactions = groupedTransactions[date]!;
        final totalAmount = transactions.fold(0.0, (sum, transaction) {
          return sum + (transaction['type'] == 'income'
              ? transaction['amount']
              : -transaction['amount']);
        });
        return _buildTransactionGroup(context, date, _groupTransactionsByCategory(transactions), totalAmount);
      },
    );
  }

  Widget _buildTransactionGroup(BuildContext context, String date, Map<String, dynamic> transactionsByCategory, double totalAmount) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
                  ),
                  Text(
                    NumberFormat.currency(symbol: '₸').format(totalAmount),
                    style: TextStyle(
                      fontSize: 18,
                      color: totalAmount >= 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: theme.dividerColor),
            ...transactionsByCategory.entries.map((entry) => _buildTransactionCategory(context, entry.key, entry.value)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCategory(BuildContext context, String category, Map<String, dynamic> transaction) {
    final theme = Theme.of(context);
    final isIncome = transaction['type'] == 'income';
    final amount = transaction['amount'] as double;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
      child: Row(
        children: [
          Image.asset(
            transaction['categoryIconPath'],
            width: 32.0,
            height: 32.0,
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(fontSize: 20.0, color: theme.textTheme.bodyLarge?.color),
                ),
                if (transaction['description'] != null)
                  Text(
                    transaction['description'],
                    style: TextStyle(fontSize: 14.0, color: theme.textTheme.bodyMedium?.color),
                  ),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : '-'}${NumberFormat.currency(symbol: '₸').format(amount)}',
            style: TextStyle(
              fontSize: 18.0,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> _groupTransactionsByDate(List<Map<String, dynamic>> transactions) {
    final Map<String, List<Map<String, dynamic>>> groupedTransactions = {};
    for (var transaction in transactions) {
      final date = DateFormat.yMMMMd().format(_parseDate(transaction['date']));
      if (!groupedTransactions.containsKey(date)) {
        groupedTransactions[date] = [];
      }
      groupedTransactions[date]!.add(transaction);
    }
    return groupedTransactions;
  }

  Map<String, Map<String, dynamic>> _groupTransactionsByCategory(List<Map<String, dynamic>> transactions) {
    final Map<String, Map<String, dynamic>> groupedTransactions = {};
    for (var transaction in transactions) {
      final category = transaction['category'];
      if (groupedTransactions.containsKey(category)) {
        groupedTransactions[category]!['amount'] += transaction['amount'];
      } else {
        groupedTransactions[category] = Map<String, dynamic>.from(transaction);
      }
    }
    return groupedTransactions;
  }
}
