import 'package:flutter/material.dart';
import 'dart:math';
import 'bottom_navigation.dart';
import 'fukidashi.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class TodayReview extends StatefulWidget {
  @override
  _TodayReviewState createState() => _TodayReviewState();
}

class _TodayReviewState extends State<TodayReview> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  bool _isAchieved = false; // 今日の目標が達成されたか
  bool _isNotificationOn = false; // 通知がONかどうか
  TimeOfDay _notificationTime = TimeOfDay(hour: 20, minute: 0); // 通知時刻

  // 仮の今日の目標
  String todayGoal = '目標1 - 小目標1-1';

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

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));
  }

  // 通知の初期化
  void _initializeNotifications() {
    const DarwinInitializationSettings macOSInitializationSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
    InitializationSettings(macOS: macOSInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    print("通知が初期化されました");
  }

  // 通知をスケジュール
  Future<void> _scheduleNotification() async {
    if (!_isNotificationOn || _isAchieved) {
      print(
          "通知はスケジュールされません (_isNotificationOn: $_isNotificationOn, _isAchieved: $_isAchieved)");
      return;
    }

    final now = DateTime.now();
    final selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      _notificationTime.hour,
      _notificationTime.minute,
    );

    // 現在時刻より前の場合、翌日にスケジュール
    final notificationTime = selectedDateTime.isBefore(now)
        ? selectedDateTime.add(Duration(days: 1))
        : selectedDateTime;

    final tzTime = tz.TZDateTime.from(notificationTime, tz.local);

    const DarwinNotificationDetails macOSNotificationDetails =
    DarwinNotificationDetails(
      subtitle: '目標確認の通知',
      presentAlert: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(macOS: macOSNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // 通知ID
      '${todayGoal}', // タイトル
      _getRandomComment(_isAchieved), // 通知内容
      tzTime, // 通知時刻
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );

    print("通知がスケジュールされました: $tzTime");
  }

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

  // ランダムコメント生成
  String _getRandomComment(bool isAchieved) {
    final random = Random();
    return (isAchieved ? _commentsWhenAchieved : _commentsWhenNotAchieved)[
    random.nextInt(isAchieved
        ? _commentsWhenAchieved.length
        : _commentsWhenNotAchieved.length)];
  }

  // ランダム画像を選択
  String _getRandomImage() {
    final random = Random();
    List<String> images = [
      'image/jinja_miko.png', // 舞妓さん
      'image/jinja_kannushi.png', // 神主さん
    ];
    return images[random.nextInt(images.length)];
  }

  // 通知時刻設定ダイアログを表示
  Future<void> _selectNotificationTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _notificationTime,
    );

    if (pickedTime != null) {
      setState(() {
        _notificationTime = pickedTime;
        print('通知時刻が設定されました: ${_notificationTime.format(context)}');
        _scheduleNotification(); // 通知を再スケジュール
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
                        Image.asset(
                          'image/icon_makimono.png',
                          width: screenSize.width,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${todayGoal}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: screenSize.width * 0.08,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Spacer(),

            // 達成ボタン
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isAchieved)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isAchieved = false;
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xFF79747E),
                        textStyle: TextStyle(
                          fontSize: screenSize.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text('取り消す'),
                    ),
                  ),
                GestureDetector(
                  onTap: () {
                    if (!_isAchieved) {
                      setState(() {
                        _isAchieved = true;
                      });
                    }
                  },
                  child: Container(
                    width: screenSize.width * 0.6,
                    height: screenSize.width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _isAchieved ? Colors.green : Colors.red,
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _isAchieved ? '達成した！' : '達成した？',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.07,
                          fontWeight: FontWeight.bold,
                          color: _isAchieved ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: _selectNotificationTime,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: Text('通知時刻を設定: ${_notificationTime.format(context)}'),
                ),
                SizedBox(height: 10),
                SwitchListTile(
                  dense: true,
                  title: Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '通知をオンにする',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  value: _isNotificationOn,
                  onChanged: (value) {
                    setState(() {
                      _isNotificationOn = value;
                      _scheduleNotification();
                    });
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Fukidashi(
                    text: _getRandomComment(_isAchieved),
                    maxWidth: screenSize.width * 0.65,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    borderRadius: 12,
                    arrowSize: 12,
                  ),
                  SizedBox(width: 10),
                  ClipRRect(
                    child: Image.asset(
                      _getRandomImage(),
                      width: screenSize.width * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
    );
  }
}
