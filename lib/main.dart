import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:mygreen/product.dart';
import 'package:mygreen/screen/login_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
late FirebaseMessaging messaging;
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );  

  final fcmToken = await messaging.getToken();
  print(fcmToken);

  await messaging.subscribeToTopic('flutter_notification');
  await initializeDateFormatting();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
        'flutter_notification', 'flutter_notification_title',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        showBadge: true,
        playSound: true);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = DarwinInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin!.initialize(initSettings,
        onDidReceiveNotificationResponse: notificationTapBackground,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  final String? message;

  MyApp({Key? key, this.message}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    setupInteractedMessage();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      RemoteNotification? notification = message?.notification!;

      print(notification != null ? notification.title : '');
    });

    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        String action = jsonEncode(message.data);

        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                priority: Priority.high,
                importance: Importance.max,
                setAsGroupSummary: true,
                styleInformation: DefaultStyleInformation(true, true),
                //largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
                channelShowBadge: true,
                autoCancel: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
            payload: action);
      }
      print('A new event was published!');
    });

    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => _handleMessage(message.data));
  }

  Future<dynamic> onSelectNotification(payload) async {
    Map<String, dynamic> action = jsonDecode(payload);
    _handleMessage(action);
  }

  Future<void> setupInteractedMessage() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => _handleMessage(value != null ? value.data : Map()));
  }

  void _handleMessage(Map<String, dynamic> data) {
    if (data['redirect'] == "product") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductPage(message: data['message'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
        primary: Colors.lightGreen,
      )),
      home: const LoginPage(),
    );
  }
}
