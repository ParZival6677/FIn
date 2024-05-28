import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Ваш SMSService с добавленным методом для отправки SMS
class SMSService {
  final String accountSid = 'AC582d37fdf266b8bd5ea1df6235dadd63';
  final String authToken = 'cf8b7d24d48b8f8453fbdbcbc455c640';
  final String twilioNumber = '+14793480811';

  Future<void> sendSMS(String to, String message) async {
    final String url = 'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken')),
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'To': to,
        'From': twilioNumber,
        'Body': message,
      },
    );

    if (response.statusCode == 201) {
      print('SMS sent successfully.');
    } else {
      print('Failed to send SMS: ${response.body}');
    }
  }
}

// Ваш RegistrationPage1
class RegistrationPage1 extends StatefulWidget {
  @override
  _RegistrationPage1State createState() => _RegistrationPage1State();
}

class _RegistrationPage1State extends State<RegistrationPage1> {
  final TextEditingController _phoneNumberController = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'KZ');
  bool isPhoneNumberVisible = false;
  String? enteredPhoneNumber;

  // Ваш SMSService
  final SMSService _smsService = SMSService();

  void _savePhoneNumber(String phoneNumber) async {
    await DatabaseProvider.dbProvider.insertPhoneNumber(phoneNumber);

    // Отправить SMS после сохранения номера
    await _smsService.sendSMS(phoneNumber, 'Ваш код для регистрации: 1234');

    // Переход на RegistrationPage2 после отправки SMS
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

// Остальной код вашего виджета
}

// Ваш RegistrationPage2
class RegistrationPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Отображение страницы RegistrationPage2
  }
}
