import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:mygreen/screen/create_account_screen.dart';
import 'package:mygreen/screen/select_pot_screen.dart';
import 'package:mygreen/provider/global_state.dart';
import 'package:mygreen/screen/calendar.dart';
import 'package:mygreen/screen/sign_up/set_id_screen.dart';
import 'package:mygreen/provider/login_state.dart';
import 'navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final cookieController = Get.put(GlobalState());

  final idController = Get.put(LoginState());

  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    final sessionToken = await _requestSessionToken(
        _idController.text, _passwordController.text, cookieController.deviceToken);

    if (sessionToken != null) {
      // 로그인 성공
      _isLoading = false;
      _idController.clear();
      _passwordController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationScreen(),
        ),
      );
    } else {
      // 로그인 실패
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('로그인 실패'),
            content: const Text('이메일과 비밀번호를 확인해주세요.'),
            actions: <Widget>[
              TextButton(
                child: const Text('확인'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<String?> _requestSessionToken(String id, String password, String token) async {
    final url =
        Uri.parse('https://iotvase.azurewebsites.net/account/login'); // 서버 주소
    Map<String, dynamic> account = {'id': id, 'password': password, 'token': token};
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(account));

    print(response.statusCode);

    if (response.statusCode == 200) {
      //cookieJar.saveFromResponse(url, response.headers['set-cookie']);
      final cookies = response.headers['set-cookie'];
      idController.setId(id);

      if (cookies != null) {
        final cookie = cookies.split(';')[0];
        cookieController.setCookie(cookie);
        print('cookie : ${cookieController.cookie}');
        return cookie;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var verticalSize = MediaQuery.of(context).size.height;
    var horizontalSize = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  width: horizontalSize * 0.6,
                  height: horizontalSize * 0.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/MyGreen.png'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  hintText: '아이디',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: '비밀번호',
                ),
                obscureText: true,
                //keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _login(),
                // 클릭할 때마다 키보드 숨김
                onTap: () => FocusScope.of(context).unfocus(),
                // 로딩 중일 때 로그인 버튼 비활성화
                enabled: !_isLoading,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('로그인'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SetIdScreen()));
                },
                child: const Text("회원가입"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
