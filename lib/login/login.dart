import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'funcs/checking.dart';

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

    //토큰
    bool token = false;

    bool validateAndSave() {
      final form = formKey.currentState;

      if (form != null && form.validate()) {
        form.save();
        return true;
      } else {
        return false;
      }
    }

    // //로그인 증명
    // Future<void> doLogin() async {
    //   final response = await http
    //       .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    //   // Wait for the HTTP GET request to complete and store the response in a variable

    //   if (response.statusCode == 200) {
    //     final jsonData = jsonDecode(response.body);
    //     print(jsonData);
    //   } else {
    //     throw Exception('Failed to load data');
    //   }
    // }

    




    return Scaffold(
        appBar: AppBar(
          //왼쪽에 배치하기
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () {
              //뒤로가기 함수 넣으면 됩니다!!
              // ignore: avoid_print
              print('back button is clicked');
              Navigator.pop(context);
            },
          ),

          title: const Text('Login'),
          //Title Center로 설정
          centerTitle: true,
        ),
        body: Container(
          //패딩값 16
          padding: const EdgeInsets.all(16),

          child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //  아이디 입력
                  TextFormField(
                    maxLength: 10,
                    style: const TextStyle(
                     
                    ),
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                        color: Colors.grey,
                      ),
hintText: '아이디를 입력하시오',
                      //default border
                      enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(0.0)),

                      //focus border
                      focusedBorder: UnderlineInputBorder(
                          //<-- SEE HERE
                          borderSide: const BorderSide(
                              width: 3, color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(0.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '아이디를 입력해주세요.';
                      }
                    },
                    onSaved: (value) => id = value!,
                  ),

                  //  패스워드 입력
                  TextFormField(
                    maxLength: 20,
                    obscureText: true,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: const Icon(
                        Icons.key_rounded,
                        color: Colors.grey,
                      ),

                      hintText: '비밀번호를 입력하시오',

                      //default border
                      enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(0.0)),

                      //focus border
                      focusedBorder: UnderlineInputBorder(
                          //<-- SEE HERE
                          borderSide: const BorderSide(
                              width: 3, color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(0.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '비밀번호를 입력해주세요';
                      }
                      
                    },
                    
                        onSaved: (value) => password = value!,
                      
                    
                  ),

                  // 제출하기 버튼
                  ElevatedButton(
                      onPressed: () {
                        if (validateAndSave()) {
                        print('$id $password');

                          if(checkingId(id)){
                            if(checkingPassword(password)){
                              token = true;
                                                      print('로그인 완료');

                              print(token);
                            }else {
                              token = false;
                              print(token);  
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('비밀번호를 확인해주세요.')));
                            }
                            
                          } else {
                              token = false;
                              print(token);  
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('아이디를 확인해주세요.')));
                            
                            
                          }

                        } else {}

                        
                        
                      },
                      style: ElevatedButton.styleFrom(),
                      child: const Text(
                        '로그인 하기',
                      ),)
                ],
              )),
        ));
  }
}
