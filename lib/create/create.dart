// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mygreen/login/login.dart';

import 'funcs/validReg.dart';

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
    Future<http.Response> postRequest(String id, password, name,email, date) async {
      final url = Uri.parse('https://iotvase.azurewebsites.net/account/create');
      Map<String, dynamic> user = {
        "id": id,
        "password": password,
        "name" : name,
        "email" : email,
        "birthday": date.year + date.month + date.day,
      };
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(user));

      print(response.statusCode);

      return response;
    }

    return Scaffold(

        //상단바
        appBar: AppBar(
          //왼쪽에 배치하기
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () {
              //뒤로가기 함수 넣으면 됩니다!!
              print('back button is clicked');
              Navigator.pop(context);
            },
          ),

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
                  child: TextFormField(
                    maxLength: 20,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    hintText: '아이디를 입력해주세요',
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
                        return 'Please enter at least one character.';
                      } else if (!validId(value)) {
                        return 'ID format must be between 6 and 18.0 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) => id = value!,
                  ),
                ),

                //  패스워드 입력
                Container(
                  margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                  child: TextFormField(
                    maxLength: 20,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    
                    obscureText: true,
                    
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: const Icon(
                        Icons.key,
                        color: Colors.black,
                      ),
                    hintText: '비밀번호를 입력해주세요',
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
                      if (value == null || value.isEmpty) {
                        return 'Please enter at least one character.';
                      } else if (!validPassword(value)) {
                        return 'The password format is at least 4 numbers, at least 1 letter, and at least 1 special character.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        password = value!;
                      });
                    },
                  ),
                ),

                //이름작성
                Container(
                  margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                  child: TextFormField(
                    maxLength: 20,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: const Icon(
                        Icons.android,
                        color: Colors.black,
                      ),
                    hintText: '이름을 입력해주세요',

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
                      if (value == null || value.isEmpty) {
                        return 'Please enter at least one character.';
                      } else if (!validId(value)) {
                        return 'ID format must be between 6 and 18.0 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) => name = value!,
                  ),
                ),

                //이메일 입력
                Container(
                  width: 200,
                  margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                  child: Row(
                    children: [
                      Expanded(
                    child : TextFormField(
                    maxLength: 20,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),hintText: '이메일 을 입력해주세요',

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
                      if (value == null || value.isEmpty) {
                        return 'Please enter at least one character.';
                      } else if (!validEmail(value)) {
                        return 'ID format must be between 6 and 18.0 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) => email = value!,
                  ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: (){

                    },
                     
                     style: ButtonStyle(
                      
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.lightGreen),

                    ),
                     child: const Text('인증 하기',
                     style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                  ),
                  ],
                ),
                ),

                Container(
                  width: 200,
                  margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                  child: Row(
                    children: [
                      Expanded(
                    child : TextFormField(
                    maxLength: 20,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: const Icon(
                        Icons.key,
                        color: Colors.black,
                      ),
                      hintText: '인증번호를 입력해주세요',

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
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter at least one character.';
                      // } else if (!validEmail(value)) {
                      //   return 'ID format must be between 6 and 18.0 characters.';
                      // }
                      return null;
                    },
                    // onSaved: (value) => email = value!,
                  ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                     
                     style: ButtonStyle(
                      
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.lightGreen),

                    ),
                     child: const Text('확인 하기',
                     style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                  ),
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
                              initialDate: date,
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
                  child: ElevatedButton(
                    onPressed: () {
                      validateAndSave();
                      print('$id $password $name $email $birthDay');
                      postRequest(id, password,name, email,date);
                      print('${date.year} ${date.month} ${date.day}');
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
                        const Size(1, 50),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
