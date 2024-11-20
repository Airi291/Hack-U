import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class MyShrine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            'マイ神社の画面',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 1), // マイ神社タブ
    );
  }
}
