// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:mygreen/widgets/MyElevatedButton.dart';
import 'package:mygreen/widgets/create_account_button.dart';
import 'package:mygreen/widgets/create_account_formfield.dart';
import 'package:mygreen/widgets/create_account_summit.dart';
import 'dart:convert';
import 'package:mygreen/screen/log_in.dart';


import 'package:mygreen/utilites/validReg.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  //날짜
  DateTime date = DateTime(2000, 01, 01);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    //아이디
    String id = '';

    //비밀번호
    String password = '';

    //생일
    String birthDay = '';

    //이름
    String name = '';

    //이메일
    String email = '';

    void validateAndSave() {
      final form = formKey.currentState;

      if (form != null && form.validate()) {
        form.save();
      } else {}
    }

//backend에 입력값 보내기
    Future<http.Response> postRequest(String id, String password, String name,
        String email, DateTime date) async {
      final url = Uri.parse('https://iotvase.azurewebsites.net/account/create');
      Map<String, dynamic> user = {
        "id": id,
        "password": password,
        "name": name,
        "email": email,
        "birthday": date.year + date.month + date.day,
      };
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(user));
      print('$id $password $name $email $birthDay');
      print(response.statusCode);

      return response;
    }

    return Scaffold(

        //상단바
        appBar: AppBar(
          //왼쪽에 배치하기
          leading: const BackButton(),

          title: const Text('CreateAccount'),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //회원 재확인
                Container(
                    //left, top, right 및 bottom
                    margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0), // Set margin for all sides

                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogInScreen()));
                          },
                          child: const Text(
                            '이미 회원이신가요 ?',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    )),

                //  아이디 입력
                Container(
                    margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                    child: MyTextFormField(
                      icon: Icons.person,
                      hintText: '아이디',
                      obscureText: false,
                      warningMessage1: '아이디를 입력해주세요.',
                      warningMessage2: '아이디는 6~10자 입니다.',
                      validValue: validId,
                      formValue: id,
                    )),

                //  패스워드 입력
                Container(
                    margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                    child: MyTextFormField(
                      icon: Icons.key,
                      hintText: '비밀번호',
                      obscureText: true,
                      warningMessage1: '비밀번호를 입력해주세요.',
                      warningMessage2: '비밀번호는 영문4자, 숫자1자, 특수문자1개 포함입니다.',
                      validValue: validPassword,
                      formValue: password,
                    )),

                //이메일 입력
                Container(
                  width: 200,
                  margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyTextFormField(
                          icon: Icons.mail,
                          hintText: '이메일',
                          obscureText: false,
                          warningMessage1: '이메일를 입력해주세요.',
                          warningMessage2: '이메일 형식을 확인해주세요.',
                          validValue: validEmail,
                          formValue: email,
                        ),
                      ),
                      const SizedBox(width: 20),
                      MyElevatedSubmitButton(Text: '확인하기'),
                    ],
                  ),
                ),

                //인증번호
                Container(
                  width: 200,
                  margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyTextFormField(
                          icon: Icons.key,
                          hintText: '인증번호',
                          obscureText: false,
                          warningMessage1: '인증번호를 입력해주세요.',
                          warningMessage2: '인증번호를 확인해 주세요.',
                          //추가해야함
                          validValue: print,
                          formValue: '',
                        ),
                      ),
                      const SizedBox(width: 20),
                      MyElevatedSubmitButton(Text: '확인하기')
                    ],
                  ),
                ),

                //  생일 입력
                Container(
                  margin: const EdgeInsets.all(18.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // Set margin for all sides
                      children: [
                        const Icon(Icons.cake),
                        Text(
                          '${date.year}년 ${date.month}월 ${date.day}일',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(1900),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );

                            if (newDate == null) return;
                            setState(() => date = newDate);
                            print(DateTime.now());
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ]),
                ),

                // 제출하기 버튼
                Container(
                  width: 10, // specify the width of the container
                  height: 50, // specify the height of the container
                  margin: const EdgeInsets.fromLTRB(100.0, 100.0, 100.0, 0.0),
                  child: MyElevatedButton(
                    id: id,
                    password: password,
                    birthDay: date,
                    name: name,
                    email: email,
                    valid: validateAndSave,
                    post: postRequest,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}