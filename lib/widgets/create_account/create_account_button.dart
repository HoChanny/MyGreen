//서버단으로 데이터 보내는 버튼

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mygreen/utilites/validReg.dart';

class MyElevatedButton extends StatefulWidget {
  TextEditingController id;
  TextEditingController password;
  TextEditingController name;
  //생일
  final DateTime birthDay;

  //이메일

  //인증번호
  final Function valid;

  final Future<Response> Function(
      String id, String password, String name, DateTime birthDay) post;

  MyElevatedButton(
      {Key? key,
      required this.id,
      required this.password,
      required this.name,
      required this.birthDay,
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

        //인증번호는 빼둠
        // if (validId(widget.id) &&
        //     validPassword(widget.password)) {
        //   widget.post(
        //       widget.id.text, widget.password.text, widget.name.text, widget.birthDay);
        // }
        var response =widget.post(widget.id.text, widget.password.text, widget.name.text, widget.birthDay);
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
        '시작하기',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}