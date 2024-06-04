import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'finance_app.db');
    print(path);

    var database = await openDatabase(path, version: 1, onCreate: initDB);
    return database;
  }

  Future<void> initDB(Database database, int version) async {
    await database.execute(
      "CREATE TABLE PhoneNumbers ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "phone TEXT"
          ")",
    );
  }

  Future<void> insertPhoneNumber(String phoneNumber) async {
    final db = await database;
    await db.insert('PhoneNumbers', {'phone': phoneNumber});
  }

  Future<List<String>> getPhoneNumbers() async {
    final db = await database;
    var res = await db.query('PhoneNumbers');
    List<String> phoneNumbers = res.isNotEmpty ? res.map((c) => c['phone'] as String).toList() : [];
    return phoneNumbers;
  }
}

class DatabaseHelper {
  static DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'finance_app.db');
    return await openDatabase(path, version: 2, onCreate: _createDb, onUpgrade: _updateDb,);
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE savings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL,
        category TEXT,
        iconPath TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE loans(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL,
        category TEXT,
        iconPath TEXT
      )
    ''');
    await db.execute('''
    CREATE TABLE accounts(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL,
      category TEXT,
      iconPath TEXT
    )
  ''');
    await db.execute('''
      CREATE TABLE plans (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      category TEXT NOT NULL,
      amount REAL NOT NULL,
      iconPath TEXT NOT NULL,
      plannedAmount REAL NOT NULL,
      createdDate TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE income (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL,
      category TEXT,
      categoryIconPath TEXT,
      date TEXT,
      account TEXT,
      accountIconPath TEXT,
      description TEXT,
      imagePath TEXT,
      photoPath TEXT
    )
  ''');
    await db.execute('''
    CREATE TABLE expense (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL,
      category TEXT,
      categoryIconPath TEXT,
      date TEXT,
      account TEXT,
      accountIconPath TEXT,
      description TEXT,
      imagePath TEXT,
      photoPath TEXT
    )
  ''');
  }

  Future<void> _updateDb(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE plans ADD COLUMN plannedAmount REAL');

    }
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE plans ADD COLUMN createdDate TEXT NOT NULL DEFAULT ''2022-01-01T00:00:00.000Z''');

      // Update existing rows with a default createdDate
      await db.execute('UPDATE plans SET createdDate = "2022-01-01T00:00:00.000Z" WHERE createdDate IS NULL');
    }
  }


  // ===================Savings====================== //

  Future<int> insertSavings(double amount, String category, String iconPath) async {
    Database db = await database;
    return await db.insert('savings', {'amount': amount, 'category': category, 'iconPath': iconPath});
  }


  Future<List<Map<String, dynamic>>> getSavings() async {
    Database db = await database;
    return await db.query('savings');
  }

  Future<int> updateSavings(int id, double amount, String iconPath) async {
    Database db = await database;
    return await db.rawUpdate(
      'UPDATE savings SET amount = amount + ? WHERE id = ?',
      [amount, id],
    );
  }

  Future<int> updateSavingsSum(String categoryName, double newAmount) async {
    Database db = await database;
    return await db.rawUpdate(
      'UPDATE savings SET amount = ? WHERE category = ?',
      [newAmount, categoryName],
    );
  }

  Future<int> deleteSavings(int id) async {
    Database db = await database;
    return await db.delete('savings', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<int>> findCategoryIdsByName(String categoryName) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'savings',
        columns: ['id'],
        where: 'category = ?',
        whereArgs: [categoryName],
      );
      List<int> categoryIds = [];
      for (var row in result) {
        categoryIds.add(row['id'] as int);
      }
      return categoryIds;
    } catch (error) {
      print("Ошибка при поиске идентификаторов категории: $error");
      return [];
    }
  }

  Future<bool> checkCategoryExists(String category) async {
    final db = await database;

    var result = await db.query('savings', where: 'category = ?', whereArgs: [category]);

    return result.isNotEmpty;
  }

  Future<String> getCategoryIconsSavings(String category) async {
    final db = await database;
    var result = await db.query('savings', where: 'category = ?', whereArgs: [category]);
    if (result.isNotEmpty) {
      return result.first['iconPath'] as String;
    } else {
      return '';
    }
  }

  Future<double> getCategorySum(String categoryName) async {
    try {
      List<Map<String, dynamic>> savings = await getSavings();
      double sum = 0;
      for (var saving in savings) {
        if (saving['category'] == categoryName) {
          sum += saving['amount'];
        }
      }
      return sum;
    } catch (error) {
      print('Ошибка при получении суммы категории: $error');
      throw error;
    }
  }

  Future<int> updateCategoryNameSavings(String oldCategoryName, String newCategoryName) async {
    Database db = await database;
    return await db.update('savings', {'category': newCategoryName}, where: 'category = ?', whereArgs: [oldCategoryName]);
  }



  // =================Loans=================== //

  Future<int> insertLoans(double amount, String category, String iconPath) async {
    Database db = await database;
    return await db.insert('loans', {'amount': amount, 'category': category, 'iconPath': iconPath});
  }

  Future<List<Map<String, dynamic>>> getLoans() async {
    Database db = await database;
    return await db.query('loans');
  }


  Future<int> updateLoans(int id, double amount, String iconPath) async {
    Database db = await database;
    return await db.rawUpdate(
      'UPDATE loans SET amount = amount + ? WHERE id = ?',
      [amount, id],
    );
  }

  Future<int> updateLoansSum(String categoryName, double newAmount) async {
    Database db = await database;
    return await db.rawUpdate(
      'UPDATE loans SET amount = ? WHERE category = ?',
      [newAmount, categoryName],
    );
  }


  Future<int> deleteLoans(int id) async {
    Database db = await database;
    return await db.delete('loans', where: 'id = ?', whereArgs: [id]);
  }



  Future<bool> checkLoansCategoryExists(String category) async {
    final db = await database;

    var result = await db.query('savings', where: 'category = ?', whereArgs: [category]);

    return result.isNotEmpty;
  }



  Future<List<int>> findCategoryIdsByNameLoans(String categoryName) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'loans',
        columns: ['id'],
        where: 'category = ?',
        whereArgs: [categoryName],
      );
      List<int> categoryIds = [];
      for (var row in result) {
        categoryIds.add(row['id'] as int);
      }
      return categoryIds;
    } catch (error) {
      print("Ошибка при поиске идентификаторов категории: $error");
      return [];
    }
  }


  Future<String> getCategoryIconsLoans(String category) async {
    final db = await database;
    var result = await db.query('loans', where: 'category = ?', whereArgs: [category]);
    if (result.isNotEmpty) {
      return result.first['iconPath'] as String;
    } else {
      return '';
    }
  }


  Future<int> updateCategoryNameLoans(String oldCategoryName, String newCategoryName) async {
    Database db = await database;
    return await db.update('loans', {'category': newCategoryName}, where: 'category = ?', whereArgs: [oldCategoryName]);
  }


  /* ===========================================
  ===================Accounts===================
  =============================================*/


  Future<int> insertAccounts(double amount, String category, String iconPath) async {
    Database db = await database;
    int accountId = await db.insert('accounts', {
      'amount': amount,
      'category': category,
      'iconPath': iconPath,
    });
    return accountId;
  }


  Future<List<Map<String, dynamic>>> getAccounts() async {
    Database db = await database;
    List<Map<String, dynamic>> accounts = await db.query('accounts');
    return accounts;
  }

  Future<List<Map<String, dynamic>>> getAllAccounts() async {
    Database db = await database;
    List<Map<String, dynamic>> accounts = await db.query('accounts');
    return accounts;
  }


  Future<int> updateAccounts(int id, double amount, String iconPath) async {
    Database db = await database;
    return await db.rawUpdate(
      'UPDATE accounts SET amount = ? WHERE id = ?',
      [amount, id],
    );
  }

  Future<int> updateAccountsSum(String categoryName, double newAmount) async {
    Database db = await database;
    return await db.rawUpdate(
      'UPDATE accounts SET amount = ? WHERE category = ?',
      [newAmount, categoryName],
    );
  }

  Future<int> deleteAccounts(int id) async {
    Database db = await database;
    return await db.delete('accounts', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<int>> findAccountsCategoryIdsByName(String categoryName) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(
        'accounts',
        columns: ['id'],
        where: 'category = ?',
        whereArgs: [categoryName],
      );
      List<int> categoryIds = [];
      for (var row in result) {
        categoryIds.add(row['id'] as int);
      }
      return categoryIds;
    } catch (error) {
      print("Ошибка при поиске идентификаторов категории: $error");
      return [];
    }
  }

  Future<bool> checkAccountsCategoryExists(String category) async {
    final db = await database;

    var result = await db.query('accounts', where: 'category = ?', whereArgs: [category]);

    return result.isNotEmpty;
  }

  Future<String> getAccountsCategoryIcons(String category) async {
    final db = await database;
    var result = await db.query('accounts', where: 'category = ?', whereArgs: [category]);
    if (result.isNotEmpty) {
      return result.first['iconPath'] as String;
    } else {
      return '';
    }
  }

  Future<double> getAccountsCategorySum(String categoryName) async {
    try {
      List<Map<String, dynamic>> accounts = await getAccounts();
      double sum = 0;
      for (var account in accounts) {
        if (account['category'] == categoryName) {
          sum += account['amount'];
        }
      }
      return sum;
    } catch (error) {
      print('Ошибка при получении суммы категории: $error');
      throw error;
    }
  }

  Future<int> updateAccountsCategoryName(String oldCategoryName, String newCategoryName) async {
    Database db = await database;
    return await db.update('accounts', {'category': newCategoryName}, where: 'category = ?', whereArgs: [oldCategoryName]);
  }

  Future<Map<String, dynamic>> getAccountById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> accounts = await db.query('accounts', where: 'id = ?', whereArgs: [id], limit: 1);
    return accounts.isNotEmpty ? accounts.first : {};
  }

  Future<void> updateAccountBalance(String account, double amount, bool isIncome) async {
    Database db = await database;
    List<Map<String, dynamic>> accountData = await db.query('accounts', where: 'category = ?', whereArgs: [account]);

    if (accountData.isNotEmpty) {
      double currentBalance = accountData.first['amount'];
      double updatedBalance = isIncome ? currentBalance + amount : currentBalance - amount;

      await db.update('accounts', {'amount': updatedBalance}, where: 'category = ?', whereArgs: [account]);
    }
  }

  // ================ Plans ================ //

  Future<int> insertPlans(double plannedAmount, String category) async {
    Database db = await database;

    double amount = await getCategoryAmount(category);
    String iconPath = await getCategoryIconsSavings(category);
    if (iconPath.isEmpty) {
      iconPath = await getAccountsCategoryIcons(category);
    }

    return await db.insert('plans', {
      'category': category,
      'amount': amount,
      'iconPath': iconPath,
      'plannedAmount': plannedAmount,
      'createdDate': DateTime.now().toIso8601String(),
    });
  }




  Future<List<Map<String, dynamic>>> getPlans() async {
    Database db = await database;
    DateTime thirtyDaysAgo = DateTime.now().subtract(Duration(days: 30));
    String thirtyDaysAgoStr = thirtyDaysAgo.toIso8601String();

    return await db.query(
      'plans',
      where: 'createdDate >= ?',
      whereArgs: [thirtyDaysAgoStr],
    );
  }




  Future<double> getCategoryAmount(String category) async {
    final db = await database;
    var result = await db.query('savings', where: 'category = ?',
        whereArgs: [category],
        columns: ['amount']);
    if (result.isNotEmpty) {
      return result.first['amount'] as double;
    } else {
      result = await db.query('accounts', where: 'category = ?',
          whereArgs: [category],
          columns: ['amount']);
      if (result.isNotEmpty) {
        return result.first['amount'] as double;
      } else {
        return 0.0;
      }
    }
  }
  Future<double> getAccountBalance(String account) async {
    final db = await database;
    final result = await db.query(
      'accounts',
      columns: ['amount'],
      where: 'category = ?',
      whereArgs: [account],
    );

    if (result.isNotEmpty) {
      return result.first['amount'] as double;
    } else {
      throw Exception('Account not found');
    }
  }


  // ============ incomes ============= //
  Future<int> insertIncome(Map<String, dynamic> data) async {
    Database db = await database;
    return await db.insert('income', data);
  }

  Future<List<Map<String, dynamic>>> getAllIncomes() async {
    final db = await database;
    return await db.query('income');
  }



  // ============ expences ============= //
  Future<int> insertExpense(Map<String, dynamic> data) async {
    Database db = await database;
    return await db.insert('expense', data);
  }

  Future<List<Map<String, dynamic>>> getAllExpenses() async {
    final db = await database;
    return await db.query('expense');
  }


}