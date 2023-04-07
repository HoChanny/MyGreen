// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mygreen/widgets/create/create_account_validNumber.dart';
import 'dart:convert';
import 'package:mygreen/screen/login.dart';

import 'package:mygreen/widgets/create/create_account_formField.dart';
import 'package:mygreen/widgets/create/create_account_submit.dart';
import '../utilites/validReg.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  //날짜
  DateTime date = DateTime(2000, 01, 01);
  final formKey = GlobalKey<FormState>();

  //아이디
  String id = '';

  //비밀번호
  String password = '';

  //생일
  String birthDay = '';

  //이메일
  String email = '';
  final TextEditingController controllerId = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool valid() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        return true;
      } else {
        return false;
      }
    }

//backend에 입력값 보내기
    Future<http.Response> postRequest(
        String id, String password, String email, DateTime date) async {
      final url = Uri.parse('https://iotvase.azurewebsites.net/account/create');
      Map<String, dynamic> user = {
        "id": id,
        "password": password,
        "email": email,
        "birthday":
            date.year.toString() + date.month.toString() + date.day.toString(),
      };
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(user));
      print('$id $password $email $birthDay');
      print(response.statusCode);

      return response;
    }

    return Scaffold(

        //상단바
        appBar: AppBar(
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
                    margin: const EdgeInsets.fromLTRB(
                        18.0, 10.0, 18.0, 10.0), // Set margin for all sides

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
                      controller: controllerId,
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
                      controller: controllerPassword,
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
                          controller: controllerEmail,
                        ),
                      ),
                      const SizedBox(width: 20),
                      MyElevatedSubmitButton(Text: '확인하기'),
                    ],
                  ),
                ),

                //인증번호
                // Container(
                //   width: 200,
                //   margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: MyTextFormField(
                //           icon: Icons.key,
                //           hintText: '인증번호',
                //           obscureText: false,
                //           warningMessage1: '인증번호를 입력해주세요.',
                //           warningMessage2: '인증번호를 확인해 주세요.',
                //           //추가해야함
                //           validValue: print,
                //           formValue: '',
                //         ),
                //       ),
                //       const SizedBox(width: 20),
                //       MyElevatedSubmitButton(Text: '확인하기')
                //     ],
                //   ),
                // ),

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
                    id: controllerId,
                    password: controllerPassword,
                    birthDay: date,
                    email: controllerEmail,
                    valid: valid,
                    post: postRequest,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
