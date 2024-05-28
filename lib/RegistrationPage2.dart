import 'package:flutter/material.dart';
import 'RegistrationPage1.dart';

class RegistrationPage2 extends StatelessWidget {
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
          SizedBox(height: 20),
          Text(
            'Введите код из СМС',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Мы отправили смс на номер +7 (999) 999-99-99',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCodeTextField(),
              SizedBox(width: 27),
              _buildCodeTextField(),
              SizedBox(width: 27),
              _buildCodeTextField(),
              SizedBox(width: 27),
              _buildCodeTextField(),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationPage1()),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            elevation: MaterialStateProperty.all<double>(0),
          ),
          child: Text(
            'Изменить номер телефона',
            style: TextStyle(
              color: Color(0xFF10B981),
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeTextField() {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: Color(0xFFCCCCCC),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
      ),
    );
  }
}