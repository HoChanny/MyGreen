import 'package:flutter/material.dart';

import 'package:mygreen/create/create.dart';
import 'package:mygreen/login/login.dart';

void main() {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
              ),
              ElevatedButton(
                child: const Text('test'),
                onPressed: () {},
              )
            ])));
  }
}
