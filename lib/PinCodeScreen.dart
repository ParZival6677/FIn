import 'package:flutter/material.dart';

class PinCodeScreen extends StatefulWidget {
  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String enteredPin = '';

  void _onDigitPressed(String digit) {
    if (enteredPin.length < 6) {
      setState(() {
        enteredPin += digit;
      });
    }
  }

  void _onBackspacePressed() {
    if (enteredPin.isNotEmpty) {
      setState(() {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Введите PIN-код',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 25,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        index < enteredPin.length
                            ? 'assets/icons/radio-bottom-active.png'
                            : 'assets/icons/radio-bottom.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int j = 1; j <= 3; j++)
                        GestureDetector(
                          onTap: () => _onDigitPressed((i * 3 + j).toString()),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            width: 60,
                            height: 60,
                            child: Center(
                              child: Text(
                                (i * 3 + j).toString(),
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 80),
                    GestureDetector(
                      onTap: () => _onDigitPressed('0'),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 46),
                        width: 60,
                        height: 60,
                        child: Center(
                          child: Text(
                            '0',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _onBackspacePressed,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: 60,
                        height: 70,
                        child: Center(
                          child: Image.asset(
                            'assets/icons/backspace-outline.png',
                            width: 40,
                            height: 40,
                            scale: 0.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Логика для обработки введенного PIN-кода
                  print('Введенный PIN: $enteredPin');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  elevation: MaterialStateProperty.all<double>(0),
                ),
                child: Text(
                  'Войти по номеру телефона',
                  style: TextStyle(
                    color: Color(0xFF10B981),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
