import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:mygreen/utilites/post_request.dart';
//import 'package:mygreen/utilites/validate_save.dart';
import 'package:mygreen/widgets/MyElevatedButton.dart';
import 'package:mygreen/widgets/MyGestureDetector.dart';
import 'package:mygreen/widgets/MyTextFormField.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();
    String id = "";
    String pw = "";

    void validateAndSave() {
      final form = loginFormKey.currentState;
      if (form != null && form.validate()) {
        form.save();
      } else {}
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("로그인"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //아이디 입력
              Container( 
                  margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                  child: MyTextFormField(
                      icon: Icons.person,
                      hintText: '아이디',
                      warningMessage: '아이디를 입력하세요.',
                      formValue: id,
                      obscureText: false,)),

              //비밀번호 입력
              Container(
                  margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),                
                  child: MyTextFormField(
                      icon: Icons.key,
                      hintText: '비밀번호',
                      warningMessage: '비밀번호를 입력하세요.',
                      formValue: pw,
                      obscureText: true)),

              //네이비게이션
              Container(
                  //left, top, right 및 bottom
                  margin: const EdgeInsets.fromLTRB(
                      10.0, 0, 10.0, 10.0), // Set margin for all sides
                  child: Row(
                    children: [
                      MyGestureDetector1(text: '아이디 찾기     '),
                      MyGestureDetector1(text: '비밀번호 찾기     '),
                      MyGestureDetector2(text: '회원가입 하기     '),
                    ],
                  )),

              //제출하기
              Container(
                margin: const EdgeInsets.fromLTRB(
                      0,0,0,0,),
                  child: MyElevatedButton(
                      id: id,
                      password: pw,
                      valid: validateAndSave,
                      post: postRequest)),
            ]
          ) ),
      )
    );
  }
}