import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../provider/global_state.dart';

class DiaryPage extends StatelessWidget {
//식물 이름
  final String plant_name;
  //일기 제목
  final String title;
  //일기 날짜
  final String date;
  //감정
  final String emotion;
  //색상
  final Color color;
  //일기 내용
  final String content;
  // 사진
  final MemoryImage image;

  DiaryPage({
    Key? key,
    required this.plant_name,
    required this.title,
    required this.date,
    required this.emotion,
    required this.color,
    required this.content,
    required this.image,
  }) : super(key: key);
  final profileController = Get.put(GlobalState());

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
    final url = 'https://yundevingv.github.io/mygreenreact/cookie/$cookie';
    print(url);
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
