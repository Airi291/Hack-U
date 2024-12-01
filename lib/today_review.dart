import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'dart:math';
import 'fukidashi.dart';

class TodayReview extends StatefulWidget {
  @override
  _TodayReviewState createState() => _TodayReviewState();
}

class _TodayReviewState extends State<TodayReview> {
  // 今日の目標が達成されたかどうかを管理するフラグ
  bool _isAchieved = false;

  // コメントリスト
  List<String> _commentsWhenNotAchieved = [
    "目標達成に向けて、あと少し！\nあきらめずにがんばろう！",
    "今日はどうだった？\n諦めないで！",
    "あなたならきっとできる！\n一歩一歩前進しよう！",
    "どんな小さな進歩も\n大きな成果に繋がりますよ！",
    "ひとつずつ進んでいきましょう\n小さな積み重ねが大きな力になりますよ！",
  ];

  List<String> _commentsWhenAchieved = [
    "目標達成おめでとうございます！\nこれからも一歩一歩前進していきましょう！",
    "よくやりましたね！達成できたあなたは本当に素晴らしい。次も頑張りましょう！",
    "お見事です！\n次も一緒に頑張りましょう！",
    "お疲れさまでした！\nこれからもどんどん成長していく姿を楽しみにしています！",
    "素晴らしい！努力が実を結びましたね。\n次もこの調子で進んでいきましょう！",
  ];

  // ランダムにコメントを選ぶための関数
  String _getRandomComment(bool isAchieved) {
    final random = Random();
    List<String> comments = isAchieved ? _commentsWhenAchieved : _commentsWhenNotAchieved;
    return comments[random.nextInt(comments.length)];
  }

  // ランダムに画像を選ぶ関数
  String _getRandomImage() {
    final random = Random();
    // 舞妓さんと神主さんの画像リスト
    List<String> images = [
      'image/jinja_miko.png',  // 舞妓さん
      'image/jinja_kannushi.png',  // 神主さん
    ];
    return images[random.nextInt(images.length)];
  }

  @override
  Widget build(BuildContext context) {
    // 画面のサイズを取得
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // 背景画像を設定
          image: DecorationImage(
            image: AssetImage('image/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.01),

            // 今日の目標
            Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: screenSize.width,
                    height: screenSize.width * 0.4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // 巻物の画像
                        Image.asset(
                          'image/icon_makimono.png',
                          width: screenSize.width, // 画面幅に合わせる
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center, // テキストを中央に配置
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double textSize = constraints.maxWidth * 0.08; // テキストサイズを親の幅に応じて変化
                                return Text(
                                  '今日の目標',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold, // 太字に設定
                                    fontSize: textSize, // サイズは動的に調整する
                                    height: 1.5, // 行間の調整
                                  ),
                                  textAlign: TextAlign.center, // テキストを中央揃え
                                  softWrap: true, // 長いテキストがあれば自動で改行
                                );
                              },
                            ),
                          ),
                        ),
                        // 目標編集ボタン
                        Positioned(
                          bottom: 20,
                          right: 50, // 右下に配置
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
            Spacer(),

            // 目標が達成されたかを管理するボタン
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 「達成した！」ボタンになった場合「取り消す」ボタンを表示
                if (_isAchieved)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isAchieved = false; // 達成フラグをリセット
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xFF79747E), // ボタンの色
                        textStyle: TextStyle(
                          fontSize: screenSize.width * 0.05, // ボタンのフォントサイズ
                          fontWeight: FontWeight.bold, // 太字に設定
                        ),
                      ),
                      child: Text('取り消す'),
                    ),
                  ),

                // 達成の状態を切り替える
                GestureDetector(
                  onTap: () {
                    if (!_isAchieved) {
                      setState(() {
                        _isAchieved = true; // 目標達成フラグを設定
                      });
                    }
                  },
                  child: Container(
                    width: screenSize.width * 0.6,
                    height: screenSize.width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.white, // 背景色を白に設定
                      shape: BoxShape.circle, // 丸い形に設定
                      border: Border.all(
                        color: _isAchieved ? Colors.green : Colors.red, // 達成状態に応じて枠線の色を変える
                        width: 4, // 枠線の太さ
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _isAchieved ? '達成した！' : '達成した？', // 達成状態に応じてテキストを変更させる
                        style: TextStyle(
                          fontSize: screenSize.width * 0.07, // フォントサイズを画面に合わせて設定
                          fontWeight: FontWeight.bold, // 太字に設定
                          color: _isAchieved ? Colors.green : Colors.red, // 達成状態に応じた色
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),

            // ランダムな舞妓さんまたは神主さん画像を表示
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 中央揃え
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 吹き出し部分
                  Fukidashi(
                    text: _getRandomComment(_isAchieved),
                    maxWidth: screenSize.width * 0.65,  // 吹き出しの横幅を調整
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    borderRadius: 12,
                    arrowSize: 12,
                  ),
                  SizedBox(width: 10),
                  // ランダムな画像を表示
                  ClipRRect(
                    child: Image.asset(
                      _getRandomImage(),
                      width: screenSize.width * 0.2,  // 画像の幅を調整
                      fit: BoxFit.cover,  // 画像を枠内に収める
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // ナビゲーション機能
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
    );
  }
}
