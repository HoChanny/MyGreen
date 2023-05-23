import 'package:flutter/material.dart';
import 'package:mygreen/screen/login_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(home:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainPage();
  }
}

class MainPage extends StatelessWidget { //Main page`
  const MainPage({ Key? key }) : super(key: key);
  final isLogin = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.lightGreen,
        )
      ),
      home:  const LoginPage(),
    );
  }
}

