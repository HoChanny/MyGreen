import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../utilites/validReg.dart';

//  회원가입 제출 버튼
class MyElevatedButton extends StatefulWidget {
  //아이디
  TextEditingController id;
  //비밀번호
  TextEditingController password;
  //생일
  final DateTime birthDay;

  //이메일
  TextEditingController email;

  //  유효성 검사
  final Function() valid;

  final Future<Response> Function(
      String id, String password, String email, DateTime birthDay) post;

  MyElevatedButton({
    Key? key,
    required this.id,
    required this.password,
    required this.birthDay,
    required this.email,
    required this.valid,
    required this.post,
  }) : super(key: key);

  _MyElevatedButton createState() => _MyElevatedButton();
}

class _MyElevatedButton extends State<MyElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print(widget.id.text);
        print(widget.password.text);
        print(widget.email.text);
        print(widget.birthDay);
        widget.valid();

        //인증번호는 빼둠
        if (validId(widget.id.text) &&
            validPassword(widget.password.text) &&
            validEmail(widget.email.text)) {
          widget.post(widget.id.text, widget.password.text, widget.email.text,
              widget.birthDay);
          print('seccess');
        } else {
          print('fail');
        }
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
