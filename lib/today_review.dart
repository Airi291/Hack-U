import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class TodayReview extends StatelessWidget {
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
            '今日の振り返りの画面',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 0), // 振り返りタブ
    );
  }
}
