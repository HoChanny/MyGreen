//서버단으로 데이터 보내는 버튼

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:mygreen/screen/log_in.dart';

class MyElevatedButton extends StatefulWidget {
  final String id;
  final String password;
  final DateTime birthDay;
  final String name;
  final String email;

  final Function valid;

  final Future<Response> Function(String id, String password, String name,
      String email, DateTime birthDay) post;

  MyElevatedButton(
      {Key? key,
      required this.id,
      required this.password,
      required this.birthDay,
      required this.name,
      required this.email,
      required this.valid,
      required this.post})
      : super(key: key);

  _MyElevatedButton createState() => _MyElevatedButton();
}

class _MyElevatedButton extends State<MyElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.valid();
        widget.post(widget.id, widget.password, widget.name, widget.email,
            widget.birthDay);
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size(1, 50),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
      child: const Text(
        '회원 가입 하기',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
