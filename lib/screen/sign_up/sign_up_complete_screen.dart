import 'package:flutter/material.dart';
import 'package:mygreen/screen/login_page.dart';

class SignUpCompleteScreen extends StatelessWidget {
  const SignUpCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    var hSize = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(size * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: size * 0.1),
          Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: Text(
              '회원가입이 완료되었습니다!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: hSize * 0.07,
              ),
            ),
          ),
          SizedBox(
            height: hSize * 0.05,
          ),
          SizedBox(height: size * 0.05),
          Center(
            child: Container(
              width: hSize * 0.7,
              height: hSize * 0.7,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/congratulation.png'),
                    fit: BoxFit.cover),
              
              ),
            ),
          ),
          SizedBox(height: size * 0.05),
          Container(
            width: hSize * 0.9,
            height: hSize * 0.1,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  LoginPage()));
                },
                child: Text(
                  '다음',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size * 0.02),
                )),
          )
        ],
      ),
    ));
  }
}
