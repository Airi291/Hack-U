import 'package:flutter/material.dart';

class GoalDetailPage extends StatelessWidget {
  final String goalName;  // 目標名
  final String imageName;  // 目標達成数画像
  final List<String> smallGoals;  // 小さな目標のリスト

  // 目標名、画像名、小さな目標のリストを受け取る
  GoalDetailPage({
    required this.goalName,
    required this.imageName,
    required this.smallGoals,
  });

  @override
  Widget build(BuildContext context) {
    // スクリーンサイズを取得
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      // 上部のバー
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),  // 高さを設定
        child: AppBar(
          title: Text(goalName),  // バーに目標名を表示
          flexibleSpace: Container(
            // 背景画像設定
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          elevation: 0, // バーの影を無効化
          iconTheme: IconThemeData(color: Colors.black), // 戻るボタン
        ),
      ),
      body: Container(
        // 背景画像の設定
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // 目標達成数画像の表示
            Image.asset(
              imageName,  // 画像を表示
              height: screenSize.height * 0.25,  // 画像の高さを画面の25%に設定
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),

            // 小さな目標リストを表示
            Expanded(
              child: ListView.builder(
                itemCount: smallGoals.length,  // 小さな目標の数だけ項目を生成
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(smallGoals[index]),  // 小さな目標をリストに表示
                    tileColor: Colors.white,  // リスト項目の背景色
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
