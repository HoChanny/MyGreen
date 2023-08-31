import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:mygreen/screen/create_account.dart';
import 'package:mygreen/screen/login.dart';
import 'package:mygreen/screen/calendar.dart';
import 'package:mygreen/screen/register_pot.dart';
import 'package:mygreen/screen/register_diary.dart';

Future<void> main() async {
  await initializeDateFormatting();
  runApp(const MaterialApp(
    title: '',
    home: Test(),
  ));
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
          children: [
            ElevatedButton(
              child: const Text('회원가입'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateAccountPage()));
              },
            ),
            ElevatedButton(
              child: const Text('로그인'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
            ElevatedButton(
              child: const Text('calendar'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalendarPage()));
              },
            ),
            // ElevatedButton(
            //   child: const Text('test'),
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const RegistrationPage()));
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
