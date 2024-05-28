import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Уведомления',
          style: TextStyle(fontSize: 24.0),
        ),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: Container(
              margin: EdgeInsets.only(right: 18),
              child: Image.asset(
                'assets/icons/trash-outline.png',
                width: 26.0,
                height: 26.0,
                scale: 0.9,
              ),
            ),
          ),
        ],
      ),

      body: Center(
        child: Text('Страница уведомлений'),
      ),
    );
  }
}