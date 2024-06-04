import 'package:flutter/material.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'settings': 'Account settings',
      'notifications_settings' : 'Notification settings',
      'notifications': 'Notifications' ,
      'notification_page': 'Notification Page',
      'theme': 'Theme',
      'change_theme': 'Change Theme',
      'language': 'Language',
      'select_language': 'Select Language',
      'total_balance': 'Total Balance',
      'my_accounts': 'My Accounts',
      'view_all': 'View All',
      'analytics': 'Analytics',
      'details': 'Details',
      'savings': 'Savings',
      'add_savings': '+ Add Savings',
      'loans': 'Loans',
      'add_loans': '+ Add Loans',
      'main': 'Home',
      'operations': 'Operations',
      'plans': 'Plans',
      'profile': 'You entered through a phone number',
      'sign_out': 'Sign Out',
      'help': 'Help',
      'planningTitle': 'Monthly budget planning',
      'planningTitle2': 'Add a category for tracking',
      'addPlanningCategory': '+ Add a category',
      'add_loan': 'Add Loan',
      'enter_amount': 'Enter amount',
      'enter_category': 'Enter category',
      'select_icon': 'Select icon',
      'warning': 'Warning',
      'category_exists': 'Category already exists. Are you sure you want to add the record?',
      'yes': 'Yes',
      'cancel': 'Cancel',
      'error': 'Error',
      'invalid_amount': 'Invalid amount. Please enter a positive number.',
      'add': 'Add',
      'confirm_delete': 'Confirm Deletion',
      'confirm_delete_message': 'Are you sure you want to delete the category "{categoryName}"?',
      'delete': 'Delete',
      'delete_error_message': 'Failed to delete one or more categories. Please try again.',
      'ok': 'OK',
      'edit': 'Edit',
      'save': 'Save',
      'add_funds': '+ Add Funds',
      'no_data': 'No data available',
      'no_sum': 'No sum available',
      'add_saving': 'Add Savings',
      'choose_icon': 'Choose Icon',
      'choose_category': 'Choose Category',
      'edit_category': 'Edit Category',
      'total': 'Total',
      'included_in_total': 'Included in total',
      'edit_accounts': 'Edit Accounts',
      'add_account': 'Add Account',
      'include_notifications': 'Enable notifications',
      'notifications_hint': 'Get notified when there are changes in this account\'s transactions',
      'exclude_from_total': 'Exclude from Total',
      'exclude_hint': 'Ignore this account and its balance in the total mode',
      'no': 'No',
      'enter_valid_data': 'Please enter valid data.',
      'edit_account': 'Edit Account',
      'enable_notifications': 'Enable notifications',
      'notifications_description': 'Receive a notification when there are changes in the operations of this account',
      'exclude_description': 'Ignore this account and its balance in the "Total" mode',
      'confirm_deletion': 'Confirm deletion',
      'delete_question': 'Are you sure you want to delete this account?',
      'save_changes': 'Save changes',
      'no_changes': 'No changes to save',
      'changes_saved': 'Changes saved successfully',
      'delete_account': 'Delete account',
      'profilepage': 'Profile',
      'add_category': 'Add category',
      'plan_added': 'The plan has been successfully added to the database',
      'plan_addition error': 'Error when adding the plan to the database',
      'add_operation': 'Add an operation',
      'income': 'Income',
      'expense': 'Expense',
      'add_details': 'Add details',
      'add_description': "Add a description",
      'hide_details': 'Hide details',
      'main_income': 'Basic incomes',
      'mainIncome': 'Main Income',
      'addCategory': 'Add Category',
      'work': 'Work',
      'family': 'Family',
      'scholarship': 'Scholarship',
      'other': 'Other',
      'choose_account': 'Choose account',
      'no_transaction': 'There are no transactions',
      'this_month': 'THIS MONTH',
      'last_month': 'LAST MONTH',
      'totals': 'Total',
      'balance': 'Remains',
    },
    'ru': {
      'settings': 'Настройки аккаунта',
      'notifications_settings' : 'Настройки уведомлений',
      'notifications': 'Уведомления' ,
      'notification_page': 'Страница уведомлений',
      'theme': 'Тема',
      'change_theme': 'Сменить тему',
      'language': 'Язык',
      'select_language': 'Выбрать язык',
      'total_balance': 'Общий баланс',
      'my_accounts': 'Мои счета',
      'view_all': 'Посмотреть все',
      'analytics': 'Аналитика',
      'details': 'Подробнее',
      'savings': 'Накопления',
      'add_savings': '+ Добавить накопления',
      'loans': 'Кредиты',
      'add_loans': '+ Добавить кредиты',
      'main': 'Главная',
      'operations': 'Операции',
      'plans': 'Планы',
      'profile': 'Вы вошли через номер телефона',
      'sign_out': 'Выход',
      'help': 'Помощь',
      'planningTitle': 'Планирования бюджета на месяц',
      'planningTitle2': 'Добавьте категорию для отслеживания',
      'addPlanningCategory': '+ Добавить категорию',
      'add_loan': 'Добавить кредит',
      'enter_amount': 'Введите сумму',
      'enter_category': 'Введите категорию',
      'select_icon': 'Выберите иконку',
      'warning': 'Предупреждение',
      'category_exists': 'Категория уже существует. Вы уверены, что хотите добавить запись?',
      'yes': 'Да',
      'cancel': 'Отмена',
      'error': 'Ошибка',
      'invalid_amount': 'Введенная сумма неверна. Пожалуйста, введите положительное число.',
      'add': 'Добавить',
      'confirm_delete': 'Подтвердите удаление',
      'confirm_delete_message': 'Вы уверены, что хотите удалить категорию "{categoryName}"?',
      'delete': 'Удалить',
      'delete_error_message': 'Не удалось удалить одну или несколько категорий. Попробуйте снова.',
      'ok': 'ОК',
      'edit': 'Редактирование',
      'save': 'Сохранить',
      'add_funds': '+ Пополнить',
      'no_data': 'Нет данных',
      'no_sum': 'Нет суммы',
      'add_saving': 'Добавить накопления',
      'choose_icon': 'Выберите иконку',
      'choose_category': 'Выберите категорию',
      'edit_category': 'Редактирование категории',
      'total': 'Итого',
      'included_in_total': 'Включены в итог',
      'edit_accounts': 'Редактировать счета',
      'add_account': 'Добавить счет',
      'include_notifications': 'Включить уведомления',
      'notifications_hint': 'Получить уведомление, когда будут изменения в операциях этого кошелька',
      'exclude_from_total': 'Исключить с Итого',
      'exclude_hint': 'Игнорировать этот кошелек и его баланс в режиме «Итого»',
      'no': 'Нет',
      'enter_valid_data': 'Пожалуйста, введите корректные данные.',
      'edit_account': 'Редактировать счет',
      'enable_notifications': 'Включить уведомления',
      'notifications_description': 'Получить уведомление, когда будут изменения в операциях этого кошелька',
      'exclude_description': 'Игнорировать этот кошелек и его баланс в режиме «Итого»',
      'confirm_deletion': 'Подтвердите удаление',
      'delete_question': 'Вы уверены, что хотите удалить этот счет?',
      'save_changes': 'Сохранить изменения',
      'no_changes': 'Нет изменений для сохранения',
      'changes_saved': 'Изменения успешно сохранены',
      'delete_account': 'Удалить счет',
      'profilepage': 'Профиль',
      'add_category': 'Добавить категорию',
      'plan_added': 'План успешно добавлен в базу данных',
      'plan_addition error': 'Ошибка при добавлении плана в базу данных',
      'add_operation': 'Добавить операцию',
      'income': 'Доход',
      'expense': 'Расход',
      'add_details': 'Добавить детали',
      'add_description': 'Добавить описание',
      'hide_details': 'Скрыть детали',
      'main_income': 'Основные доходы',
      'mainIncome': 'Основные доходы',
      'addCategory': 'Добавить категорию',
      'work': 'Работа',
      'family': 'Семья',
      'scholarship': 'Стипендия',
      'other': 'Другое',
      'choose_account': 'Выберите счет',
      'no_transaction': 'Нет транзакций',
      'this_month': 'В ЭТОМ МЕСЯЦЕ',
      'last_month': 'В ПРОШЛОМ МЕСЯЦЕ',
      'totals': 'Итого',
      'balance': 'Остаток',
    },
    'kk': {
      'settings': 'Тіркелгі параметрлері',
      'notifications_settings' : 'Хабарландыру параметрлері',
      'notifications': 'Хабарламалар' ,
      'notification_page': 'Хабарландыру беті',
      'theme': 'Тақырып',
      'change_theme': 'Тақырыпты өзгерту',
      'language': 'Тіл',
      'select_language': 'Тілді таңдау',
      'total_balance': 'Жалпы баланс',
      'my_accounts': 'Менің шоттарым',
      'view_all': 'Барлығын көру',
      'analytics': 'Аналитика',
      'details': 'Толығырақ',
      'savings': 'Жинақтар',
      'add_savings': '+ Жинақ қосу',
      'loans': 'Несиелер',
      'add_loans': '+ Несие қосу',
      'main': 'Басты бет',
      'operations': 'Операциялар',
      'plans': 'Жоспарлар',
      'profile': 'Сіз телефон нөмірі арқылы кірдіңіз',
      'sign_out': 'Шығу',
      'help': 'Көмек',
      'planningTitle': 'Бір айға бюджетті жоспарлау',
      'planningTitle2': 'Бақылау үшін санатты қосыңыз',
      'addPlanningCategory': '+ Санат қосу',
      'add_loan': 'Несие қосу',
      'enter_amount': 'Соманы енгізіңіз',
      'enter_category': 'Санатты енгізіңіз',
      'select_icon': 'Белгіні таңдаңыз',
      'warning': 'Ескерту',
      'category_exists': 'Санат бар. Жазбаны қосқыңыз келетініне сенімдісіз бе?',
      'yes': 'Иә',
      'cancel': 'Бас тарту',
      'error': 'Қате',
      'invalid_amount': 'Қате сома. Оң санды енгізіңіз.',
      'add': 'Қосу',
      'confirm_delete': 'Жоюды растаңыз',
      'confirm_delete_message': 'Сіз "{categoryName}" санатын жоюды қалайсыз ба?',
      'delete': 'Жою',
      'delete_error_message': 'Бір немесе бірнеше санатты жою сәтсіз аяқталды. Қайтадан көріңіз.',
      'ok': 'Жарайды',
      'edit': 'Өңдеу',
      'save': 'Сақтау',
      'add_funds': '+ Қаржы қосу',
      'no_data': 'Деректер жоқ',
      'no_sum': 'Сома жоқ',
      'add_saving': 'Жинақ қосу',
      'choose_icon': 'Белгіні таңдау',
      'choose_category': 'Санатты таңдау',
      'edit_category': 'Санатты өзгерту',
      'total': 'Барлығы',
      'included_in_total': 'Жалпыға енгізілген',
      'edit_accounts': 'Есептерді өңдеу',
      'add_account': 'Есептік жазба қосу',
      'include_notifications': 'Хабарландыруларды қосу',
      'notifications_hint': 'Осы шоттағы транзакциялар өзгерген кезде хабарлама алыңыз',
      'exclude_from_total': 'Жалпыдан шығарып тастау',
      'exclude_hint': 'Бұл есептік жазбаны және оның балансын жалпы режимде елемеу',
      'no': 'Жоқ',
      'enter_valid_data': 'Дұрыс деректерді енгізіңіз.',
      'edit_account': 'Есептік жазбаны өңдеу',
      'enable_notifications': 'Хабарландыруларды қосу',
      'notifications_description': 'Бұл әмияндағы операцияларда өзгерістер болған кезде хабарлама алыңыз',
      'exclude_description': 'Бұл әмиянды және оның балансын "Барлығы" режимінде елемеу',
      'confirm_deletion': 'Жоюды растаңыз',
      'delete_question': 'Сіз бұл есептік жазбаны жойғыңыз келетініне сенімдісіз бе?',
      'save_changes': 'Өзгерістерді сақтау',
      'no_changes': 'Сақтайтын өзгерістер жоқ',
      'changes_saved': 'Өзгерістер сәтті сақталды',
      'delete_account': 'Есептік жазбаны жою',
      'profilepage': 'Профиль',
      'add_category': 'Санатты қосу',
      'plan_added': 'Жоспар дерекқорға сәтті қосылды',
      'plan_addition_error': 'Деректер базасына жоспар қосу кезіндегі қате',
      'add_operation': 'Операцияны қосыңыз',
      'income': 'Табыс',
      'expense': 'Тұтыну',
      'add_details': 'Мәліметтерді қосу',
      'add_description': 'Сипаттама қосу',
      'hide_details': 'Мәліметтерді жасыру',
      'main_income': 'Негізгі кірістер',
      'mainIncome': 'Негізгі табыс',
      'addCategory': 'Санат қосу',
      'work': 'Жұмыс',
      'family': 'Отбасы',
      'scholarship': 'Стипендия',
      'other': 'Басқа',
      'choose_account': 'Есептерді таңдаңыз',
      'no_transaction': 'Tранзакциялар жоқ',
      'this_month': 'ОСЫ АЙДА',
      'last_month': 'ӨТКЕН АЙДА',
      'totals': 'Барлығы',
      'balance': 'Қалдық',
    },
  };

  final Locale locale;

  AppLocalizations(this.locale);

  String get mainIncome {
    return _localizedValues[locale.languageCode]!['mainIncome']!;
  }

  String get thisMonth {
    return _localizedValues[locale.languageCode]!['this_month']!;
  }
  String get lastMonth {
    return _localizedValues[locale.languageCode]!['last_month']!;
  }
  String get totals {
    return _localizedValues[locale.languageCode]!['totals']!;
  }
  String get balance {
    return _localizedValues[locale.languageCode]!['balance']!;
  }

  String get noTransactions {
    return _localizedValues[locale.languageCode]!['no_transaction']!;
  }

  String get chooseAccount {
    return _localizedValues[locale.languageCode]!['choose_account']!;
  }

  String get addCategory {
    return _localizedValues[locale.languageCode]!['addCategory']!;
  }

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }

  String get hideDetails {
    return _localizedValues[locale.languageCode]!['hide_details']!;
  }

  String get enterDescription {
    return _localizedValues[locale.languageCode]!['add_description']!;
  }

  String get addDetails {
    return _localizedValues[locale.languageCode]!['add_details']!;
  }
  String get income {
    return _localizedValues[locale.languageCode]!['income']!;
  }

  String get expense {
    return _localizedValues[locale.languageCode]!['expense']!;
  }

  String get addOperation {
    return _localizedValues[locale.languageCode]!['add_operation']!;
  }

  String get plan_added {
    return _localizedValues[locale.languageCode]!['plan_added']!;
  }

  String get planAdditionError {
    return _localizedValues[locale.languageCode]!['plan_addition_error']!;
  }

  String get chooseCategory {
    return _localizedValues[locale.languageCode]!['choose_category']!;
  }

  String get editAccount {
    return _localizedValues[locale.languageCode]!['edit_account']!;
  }

  String get enterAmount {
    return _localizedValues[locale.languageCode]!['enter_amount']!;
  }

  String get enterCategory {
    return _localizedValues[locale.languageCode]!['enter_category']!;
  }

  String get enableNotifications {
    return _localizedValues[locale.languageCode]!['enable_notifications']!;
  }

  String get notificationsDescription {
    return _localizedValues[locale.languageCode]!['notifications_description']!;
  }

  String get excludeFromTotal {
    return _localizedValues[locale.languageCode]!['exclude_from_total']!;
  }

  String get excludeDescription {
    return _localizedValues[locale.languageCode]!['exclude_description']!;
  }

  String get confirmDeletion {
    return _localizedValues[locale.languageCode]!['confirm_deletion']!;
  }

  String get deleteQuestion {
    return _localizedValues[locale.languageCode]!['delete_question']!;
  }

  String get cancel {
    return _localizedValues[locale.languageCode]!['cancel']!;
  }

  String get delete {
    return _localizedValues[locale.languageCode]!['delete']!;
  }

  String get saveChanges {
    return _localizedValues[locale.languageCode]!['save_changes']!;
  }

  String get noChanges {
    return _localizedValues[locale.languageCode]!['no_changes']!;
  }

  String get changesSaved {
    return _localizedValues[locale.languageCode]!['changes_saved']!;
  }

  String get deleteAccount {
    return _localizedValues[locale.languageCode]!['delete_account']!;
  }

  String get addAccount {
    return _localizedValues[locale.languageCode]!['add_account']!;
  }

  String get includeNotifications {
    return _localizedValues[locale.languageCode]!['include_notifications']!;
  }

  String get notificationsHint {
    return _localizedValues[locale.languageCode]!['notifications_hint']!;
  }

  String get excludeHint {
    return _localizedValues[locale.languageCode]!['exclude_hint']!;
  }

  String get no {
    return _localizedValues[locale.languageCode]!['no']!;
  }

  String get enterValidData {
    return _localizedValues[locale.languageCode]!['enter_valid_data']!;
  }

  String get settings {
    return _localizedValues[locale.languageCode]!['settings']!;
  }

  String get notifications_settings {
    return _localizedValues[locale.languageCode]!['notifications_settings']!;
  }

  String get theme {
    return _localizedValues[locale.languageCode]!['theme']!;
  }

  String get profilepage {
    return _localizedValues[locale.languageCode]!['profilepage']!;
  }

  String get changeTheme {
    return _localizedValues[locale.languageCode]!['change_theme']!;
  }

  String get language {
    return _localizedValues[locale.languageCode]!['language']!;
  }

  String get selectLanguage {
    return _localizedValues[locale.languageCode]!['select_language']!;
  }

  String get totalBalance {
    return _localizedValues[locale.languageCode]!['total_balance']!;
  }

  String get myAccounts {
    return _localizedValues[locale.languageCode]!['my_accounts']!;
  }

  String get viewAll {
    return _localizedValues[locale.languageCode]!['view_all']!;
  }

  String get analytics {
    return _localizedValues[locale.languageCode]!['analytics']!;
  }

  String get details {
    return _localizedValues[locale.languageCode]!['details']!;
  }

  String get savings {
    return _localizedValues[locale.languageCode]!['savings']!;
  }

  String get addSavings {
    return _localizedValues[locale.languageCode]!['add_savings']!;
  }

  String get loans {
    return _localizedValues[locale.languageCode]!['loans']!;
  }

  String get addLoans {
    return _localizedValues[locale.languageCode]!['add_loans']!;
  }

  String get main {
    return _localizedValues[locale.languageCode]!['main']!;
  }

  String get operations {
    return _localizedValues[locale.languageCode]!['operations']!;
  }

  String get plans {
    return _localizedValues[locale.languageCode]!['plans']!;
  }

  String get profile {
    return _localizedValues[locale.languageCode]!['profile']!;
  }

  String get signOut {
    return _localizedValues[locale.languageCode]!['sign_out']!;
  }

  String get help {
    return _localizedValues[locale.languageCode]!['help']!;
  }

  String get planningTitle {
    return _localizedValues[locale.languageCode]!['planningTitle']!;
  }

  String get planningTitle2 {
    return _localizedValues[locale.languageCode]!['planningTitle2']!;
  }

  String get addPlanningCategory {
    return _localizedValues[locale.languageCode]!['addPlanningCategory']!;
  }

  String get notifications {
    return _localizedValues[locale.languageCode]!['notifications']!;
  }

  String get notificationPage {
    return _localizedValues[locale.languageCode]!['notification_page']!;
  }

  String get addLoan {
    return _localizedValues[locale.languageCode]!['add_loan']!;
  }


  String get selectIcon {
    return _localizedValues[locale.languageCode]!['select_icon']!;
  }

  String get warning {
    return _localizedValues[locale.languageCode]!['warning']!;
  }

  String get categoryExists {
    return _localizedValues[locale.languageCode]!['category_exists']!;
  }

  String get yes {
    return _localizedValues[locale.languageCode]!['yes']!;
  }

  String get error {
    return _localizedValues[locale.languageCode]!['error']!;
  }

  String get invalidAmount {
    return _localizedValues[locale.languageCode]!['invalid_amount']!;
  }

  String get add {
    return _localizedValues[locale.languageCode]!['add']!;
  }

  String get confirmDelete {
    return _localizedValues[locale.languageCode]!['confirm_delete']!;
  }

  String get confirmDeleteMessage {
    return _localizedValues[locale.languageCode]!['confirm_delete_message']!;
  }

  String get deleteErrorMessage {
    return _localizedValues[locale.languageCode]!['delete_error_message']!;
  }

  String get ok {
    return _localizedValues[locale.languageCode]!['ok']!;
  }

  String get edit {
    return _localizedValues[locale.languageCode]!['edit']!;
  }


  String get save {
    return _localizedValues[locale.languageCode]!['save']!;
  }

  String get addFunds {
    return _localizedValues[locale.languageCode]!['add_funds']!;
  }

  String get noData {
    return _localizedValues[locale.languageCode]!['no_data']!;
  }

  String get noSum {
    return _localizedValues[locale.languageCode]!['no_sum']!;
  }

  String get addSaving {
    return _localizedValues[locale.languageCode]!['add_saving']!;
  }

  String get chooseIcon {
    return _localizedValues[locale.languageCode]!['choose_icon']!;
  }

  String get editCategory {
    return _localizedValues[locale.languageCode]!['edit_category']!;
  }

  String get total {
    return _localizedValues[locale.languageCode]!['total']!;
  }

  String get includedInTotal {
    return _localizedValues[locale.languageCode]!['included_in_total']!;
  }

  String get editAccounts {
    return _localizedValues[locale.languageCode]!['edit_accounts']!;
  }
}



class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru', 'kk'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
