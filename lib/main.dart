import 'package:flutter/material.dart';
import 'firstpage.dart';
import 'my_shrine.dart';
import 'goal_list.dart';
import 'today_review.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI神社',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/shrine': (context) => MyShrine(),
        '/goals': (context) => GoalList(),
        '/review': (context) => TodayReview(),
      },
    );
  }
}
