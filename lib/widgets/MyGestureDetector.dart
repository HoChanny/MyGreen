import 'package:flutter/material.dart';
import 'package:mygreen/screen/log_in.dart';
import 'package:mygreen/screen/create_account_screen.dart';
//import 'package:mygreen/create/create.dart';

class MyGestureDetector1 extends StatefulWidget {
  final String text;

  MyGestureDetector1({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _MyGestureDetector1State createState() => _MyGestureDetector1State();
}

class _MyGestureDetector1State extends State<MyGestureDetector1> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LogInScreen()),
        );
      },
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}

//회원가입 페이지 이동
class MyGestureDetector2 extends StatefulWidget {
  final String text;

  MyGestureDetector2({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _MyGestureDetector2State createState() => _MyGestureDetector2State();
}

class _MyGestureDetector2State extends State<MyGestureDetector2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateAccountPage()),
        );
      },
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}

