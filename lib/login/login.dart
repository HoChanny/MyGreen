import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:mygreen/login/widgets/MyGestureDetector/MyGestureDetector.dart';
import 'package:mygreen/login/widgets/MyTextFormField/MyTextFormField.dart';
import 'package:mygreen/login/widgets/MyElevatedButton/MyElevatedButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    //아이디
    String id = '';

    //비밀번호
    String password = '';

    void validateAndSave() {
      final form = formKey.currentState;
      if (form != null && form.validate()) {
        form.save();
      } else {}
    }

//backend에 입력값 보내기
    Future<http.Response> postRequest(String id, String password) async {
      final url = Uri.parse('https://iotvase.azurewebsites.net/account/login');
      Map<String, dynamic> user = {
        "id": id,
        "password": password,
      };
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(user));
      print(response.statusCode);
      return response;
    }

    return Scaffold(
      appBar: AppBar(
        //왼쪽에 배치하기
        leading: const BackButton(),

        title: const Text('Login'),
        //Title Center로 설정
        centerTitle: true,
      ),

      //바디
      body: Container(
        //패딩값 16
        padding: const EdgeInsets.all(16),

        child: Form(
          key: formKey,
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
                      formValue: password,
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
                      password: password,
                      valid: validateAndSave,
                      post: postRequest)),
            ],
          ),
        ),
      ),
    );
  }
}
