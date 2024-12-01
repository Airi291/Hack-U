import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'goal_detailpage.dart';

class GoalList extends StatelessWidget {
  // 仮の目標データ　
  final List<String> bigGoals = [
    '目標1', '目標2', '目標3', '目標4', '目標5', '目標6', '目標7', '目標8'
  ];

  // 仮の小さな目標データ（各大きな目標に対して8つの小さな目標）
  final List<List<String>> smallGoals = [
    ['小目標1-1', '小目標1-2', '小目標1-3', '小目標1-4', '小目標1-5', '小目標1-6', '小目標1-7', '小目標1-8'],
    ['小目標2-1', '小目標2-2', '小目標2-3', '小目標2-4', '小目標2-5', '小目標2-6', '小目標2-7', '小目標2-8'],
    ['小目標3-1', '小目標3-2', '小目標3-3', '小目標3-4', '小目標3-5', '小目標3-6', '小目標3-7', '小目標3-8'],
    ['小目標4-1', '小目標4-2', '小目標4-3', '小目標4-4', '小目標4-5', '小目標4-6', '小目標4-7', '小目標4-8'],
    ['小目標5-1', '小目標5-2', '小目標5-3', '小目標5-4', '小目標5-5', '小目標5-6', '小目標5-7', '小目標5-8'],
    ['小目標6-1', '小目標6-2', '小目標6-3', '小目標6-4', '小目標6-5', '小目標6-6', '小目標6-7', '小目標6-8'],
    ['小目標7-1', '小目標7-2', '小目標7-3', '小目標7-4', '小目標7-5', '小目標7-6', '小目標7-7', '小目標7-8'],
    ['小目標8-1', '小目標8-2', '小目標8-3', '小目標8-4', '小目標8-5', '小目標8-6', '小目標8-7', '小目標8-8'],
  ];

  // 仮の目標達成数
  final List<int> goalImageNumbers = [5, 3, 2, 7, 1, 6, 8, 4];

  // 番号に基づいた画像のファイル名を返す
  String getImageName(int goalNumber) {
    return 'image/${goalNumber}.png';
  }

  @override
  Widget build(BuildContext context) {
    // 画面サイズを取得
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      // 背景画像設定
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // 今年の抱負を表示
            SizedBox(
              height: screenSize.height * 0.03,  // 画面の上部に余白を追加
            ),
            Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: screenSize.width,  // 画面幅に合わせたサイズ
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // 絵馬の画像
                        Image.asset(
                          'image/ema.png',
                          width: screenSize.width,  // 画面幅に合わせて表示
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment(0.0, 0.2),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // テキストサイズを画面幅に基づいて設定
                                double textSize = constraints.maxWidth * 0.08;
                                return Text(
                                  '今年１年の抱負',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: textSize,
                                    height: 1.5,  // 行間の調整
                                  ),
                                  textAlign: TextAlign.center,  // 中央揃え
                                  softWrap: true,  // テキストが改行される
                                );
                              },
                            ),
                          ),
                        ),
                        // 目標編集ボタン
                        Positioned(
                          bottom: 8,
                          right: 30, // 右下に配置
                          child: IconButton(
                            icon: Icon(
                              Icons.edit, // 編集アイコン
                              color: Color(0xFF79747E), // アイコンの色
                              size: screenSize.width * 0.08, // アイコンサイズ
                            ),
                            onPressed: () {
                              // 編集ボタンが押された場合
                              print('目標を編集');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // 目標リスト
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,  // 横に3つ並べる
                  crossAxisSpacing: 8,  // 横方向の間隔
                  mainAxisSpacing: 8,  // 縦方向の間隔
                  childAspectRatio: 0.8,
                ),
                itemCount: bigGoals.length,
                itemBuilder: (context, index) {
                  // 外部から渡された目標達成数を取得
                  int goalImageNumber = goalImageNumbers[index];

                  // 目標達成数に基づいて画像を取得
                  String imageName = getImageName(goalImageNumber);

                  return GestureDetector(
                    onTap: () {
                      // 目標をタップしたときに詳細ページへ遷移
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoalDetailPage(
                            goalName: bigGoals[index],  // 大きな目標
                            imageName: imageName,  // 目標達成数
                            smallGoals: smallGoals[index],  // 小さな目標のリストを渡す
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,  // リストに影をつける
                      color: Color(0xFFf4ede6),  // リストの背景色
                      child: Column(
                        children: [
                          // 目標ごとの画像
                          Container(
                            height: screenSize.height * 0.12,  // 画像の高さを設定
                            width: double.infinity,  // 横幅は最大
                            child: Image.asset(
                              imageName,  // 動的に取得した画像を表示
                              fit: BoxFit.contain,
                            ),
                          ),
                          // 目標テキスト
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  bigGoals[index],
                                  style: TextStyle(
                                    fontSize: 16.0,  // フォントサイズ
                                    fontWeight: FontWeight.w500,  // フォントの太さ
                                  ),
                                  textAlign: TextAlign.center,  // テキストの中央揃え
                                  softWrap: true,  // テキストを折り返す
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // ナビゲーション機能（下部ナビゲーションバー）
      bottomNavigationBar: BottomNavigation(currentIndex: 2),
    );
  }
}
