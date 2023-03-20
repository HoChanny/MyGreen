import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'package:mygreen/create/create.dart';

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

 void validateAndSave() {
      final form = formKey.currentState;

      if (form != null && form.validate()) {
        form.save();
      } else {}
    }

//backend에 입력값 보내기
    Future<http.Response> postRequest(String id, password) async {
      final url = Uri.parse('https://iotvase.azurewebsites.net/account/login');
      Map<String, dynamic> user = {
        "id": id,
        "password": password,
        
      };
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(user));
      print(response.body);
      print(response.statusCode);
      print('$id $password');
      return response;
    }
    return Scaffold(
      appBar: AppBar(
        //왼쪽에 배치하기
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            // ignore: avoid_print
            print('back button is clicked');
            Navigator.pop(context);
          },
        ),

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
              //  아이디 입력
              Container(
                  child: TextFormField(
                maxLength: 10,
                style: const TextStyle(),
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  //add prefix icon
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
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
                      borderSide:
                          const BorderSide(width: 3, color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(0.0)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '아이디를 입력해주세요.';
                  } return null;
                },
                onSaved: (value) => id = value!,
              )),

              //  패스워드 입력
              Container(
                child: TextFormField(
                  maxLength: 20,
                  obscureText: true,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    //add prefix icon
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.black,
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
                    } return null;
                  },
                  onSaved: (value) => password = value!,
                ),
              ),

              Container(
                  //left, top, right 및 bottom
                  margin: const EdgeInsets.fromLTRB(
                      10.0, 0, 10.0, 10.0), // Set margin for all sides

                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text(
                          '아이디 찾기     ',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text(
                          '비밀번호 찾기     ',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateAccountPage()));
                        },
                        child: const Text(
                          '회원 가입     ',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  )),

              Container(
                // 제출하기 버튼
                child: ElevatedButton(
                  onPressed: () {
                    validateAndSave();
                    postRequest(id, password);
                    print('$id $password');
                    // if (validateAndSave()) {
                    //   if (checkingId(id)) {
                    //     if (checkingPassword(password)) {
                    //       token = true;
                    //       print('로그인 완료');
                    //       print(token);
                    //     } else {
                    //       token = false;
                    //       print(token);
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //           SnackBar(content: Text('비밀번호를 확인해주세요.')));
                    //     }
                    //   } else {
                    //     token = false;
                    //     print(token);
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(content: Text('아이디를 확인해주세요.')));
                    //   }
                    // } else {}
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightGreen),
                    fixedSize: MaterialStateProperty.all<Size>(
                      const Size(1000, 50),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  child: const Text(
                    '로그인 하기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
