import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'database.dart';
import 'RegistrationPage2.dart';
import 'sms_service.dart';

class RegistrationPage1 extends StatefulWidget {
  @override
  _RegistrationPage1State createState() => _RegistrationPage1State();
}

class _RegistrationPage1State extends State<RegistrationPage1> {
  final TextEditingController _phoneNumberController = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'KZ');
  bool isPhoneNumberVisible = false;
  String? enteredPhoneNumber;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _savePhoneNumber(String phoneNumber) async {
    await DatabaseProvider.dbProvider.insertPhoneNumber(phoneNumber);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/logo.png',
            width: 120,
            height: 120,
            scale: 0.7,
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              'Введите номер телефона, чтобы войти',
              style: TextStyle(
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isPhoneNumberVisible = !isPhoneNumberVisible;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Visibility(
                visible: !isPhoneNumberVisible,
                child: Container(
                  height: 40,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.transparent,
                        width: 2.0,
                      ),
                      left: BorderSide(
                        color: Colors.transparent,
                        width: 2.0,
                      ),
                      right: BorderSide(
                        color: Colors.transparent,
                        width: 2.0,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2.0, // Толщина черной полоски
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Visibility(
            visible: isPhoneNumberVisible,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  InternationalPhoneNumberInput(
                    inputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 15, left: 0),
                      border: InputBorder.none,
                      hintText: 'Номер телефона',
                      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                    ),
                    initialValue: number,
                    onInputChanged: (PhoneNumber value) {
                      print(value.phoneNumber);
                      enteredPhoneNumber = value.phoneNumber;
                    },
                    inputBorder: InputBorder.none,
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    formatInput: false,
                    maxLength: 15,
                    keyboardType: TextInputType.phone,
                    onInputValidated: (bool value) {
                      if (value) {
                        _savePhoneNumber(enteredPhoneNumber!);
                      }
                    },
                  ),
                  Divider(
                    height: 2,
                    color: Colors.black,
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