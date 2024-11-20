import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child; // 背景上に配置するウィジェット

  const BackgroundWidget({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('image/background.png'), // 統一された背景画像
          fit: BoxFit.cover,
        ),
      ),
      child: child, // 子ウィジェットを背景上に表示
    );
  }
}
