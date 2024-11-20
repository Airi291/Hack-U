import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFFEB5649), // 現在のページの色（赤系）
      unselectedItemColor: const Color(0xFF79747E), // その他のページの色（グレー系）
      backgroundColor: Colors.white, // タブの背景色を白に設定
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/review');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/shrine');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/goals');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.today),
          label: '振り返り',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.temple_buddhist),
          label: 'マイ神社',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: '目標一覧',
        ),
      ],
    );
  }
}
