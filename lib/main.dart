import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mygreen/screen/login_page.dart';
import 'package:get/get.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:mygreen/screen/select_pot_screen.dart';

import 'firebase_options.dart';
import 'screen/navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  await initializeDateFormatting();
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainPage();
  }
}

class MainPage extends StatelessWidget {
  //Main page`
  const MainPage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily : 'Apple',
          colorScheme: const ColorScheme.light(
        primary: Colors.lightGreen,
        
      )),
      home: LoginPage(),
    );
  }
}
