import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    //아이디
    String _id = '';

    //비밀번호
    String _password = '';

    void validateAndSave() {
      final form = formKey.currentState;

      if (form != null && form.validate()) {
        form.save();
      } else {}
    }

    return Scaffold(
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
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                        color: Colors.grey,
                      ),

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
                        return '아이디를 입력해주세요..';
                      }
                    },
                    onSaved: (value) => _id = value!,
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
                    onSaved: (value) {
                      setState(() {
                        _password = value!;
                      });
                    },
                  ),

                  // 제출하기 버튼
                  ElevatedButton(
                      onPressed: () {
                        validateAndSave();
                        print('$_id $_password');
                      },
                      style: ElevatedButton.styleFrom(),
                      child: const Text(
                        '로그인 하기',
                      ))
                ],
              )),
        ));
  }
}
