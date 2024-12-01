import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class TodayReview extends StatefulWidget {
  @override
  _TodayReviewState createState() => _TodayReviewState();
}

class _TodayReviewState extends State<TodayReview> {
  // 今日の目標が達成されたかどうかを管理するフラグ
  bool _isAchieved = false;

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
                          bottom: 8,
                          right: 8, // 右下に配置
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

            // 舞妓さんコメント
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 中央揃え
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 吹き出し部分
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 内側に余白を設定
                    decoration: BoxDecoration(
                      color: Colors.white, // 吹き出しの背景色
                      borderRadius: BorderRadius.circular(12), // 角を丸くする
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45, // 影の色
                          offset: Offset(0, 3), // 影の位置
                          blurRadius: 6, // 影のぼかし具合
                        ),
                      ],
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: screenSize.width * 0.5,
                      ),
                      child: Text(
                        '舞妓さんコメント', // コメント内容
                        style: TextStyle(
                          fontSize: 16, // フォントサイズ
                          color: Colors.black, // テキストの色
                          fontWeight: FontWeight.w600, // フォントの太さ
                        ),
                        softWrap: true, // 長いテキストであれば自動で改行
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    'image/jinja_miko.png',
                    width: screenSize.width * 0.2,
                    fit: BoxFit.cover, // 画像を枠内に収める
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // ナビゲーション機能
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
    );
  }
}
