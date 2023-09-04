import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:mygreen/screen/create_account.dart';
import 'package:mygreen/screen/login.dart';
import 'package:mygreen/screen/calendar.dart';
import 'package:mygreen/screen/home.dart';
import 'package:mygreen/widgets/navigation/navigation.dart';

void main() async {
  await initializeDateFormatting();
  runApp(
    MaterialApp(
      title: '',
      home: HomeScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/createAccount':
            return MaterialPageRoute(
              builder: (context) => CreateAccountPage(),
            );
          case '/login':
            return MaterialPageRoute(
              builder: (context) => LoginPage(),
            );
          case '/calendar':
            return MaterialPageRoute(
              builder: (context) => CalendarPage(),
            );
          case '/home':
            return MaterialPageRoute(
              builder: (context) => HomeScreen(),
            );
        }
      },
    ),
  );
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
      bottomNavigationBar: Navigation(),
    );
  }
}
