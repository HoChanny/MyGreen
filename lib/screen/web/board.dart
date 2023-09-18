import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreen/provider/login_state.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../provider/global_state.dart';

class BoardPage extends StatelessWidget {
  BoardPage({Key? key}) : super(key: key);

  final profileController = Get.put(GlobalState());

  final loginController = Get.put(LoginState());

  // 쿠키를 가져오는 함수
  Future<String> getCookie() async {
    final value = profileController.cookie;
    return value;
  }

  // 쿠키를 설정하는 함수
  Future<void> setCookie(value) async {
    profileController.cookie = value;
  }

  @override
  Widget build(BuildContext context) {
    final cookie = profileController.cookie;
    final userid = loginController.id;

    final url = 'https://yundevingv.github.io/mygreenreact/board/$userid';
    return Scaffold(
      body: FutureBuilder<String>(
        future: getCookie(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (String url) async {
                // 웹 페이지가 로드된 후 쿠키를 설정
                print(snapshot.data);
                await setCookie(snapshot.data);
              },
            );
          } else {
            // 쿠키를 가져오는 동안 로딩 중인 경우
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}