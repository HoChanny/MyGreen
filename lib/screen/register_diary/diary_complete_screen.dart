import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreen/provider/resgister_diary_state.dart';
import 'package:mygreen/provider/global_state.dart';
import '../../navigation.dart';
import 'package:http/http.dart' as http;

import 'dart:io';

class DiaryCompleteScreen extends StatelessWidget {
  final data = Get.find<DiaryState>();
  final cookieController = Get.put(GlobalState());

  DiaryCompleteScreen({super.key});

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
              '일기작성이 완료되었습니다!',
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
                  postDiaryData(
                      context,
                      data.diaryData['image'],
                      'asd',
                      data.diaryData['emotion'],
                      data.diaryData['title'],
                      data.diaryData['content'],
                      data.diaryData['date'],
                      true,
                      'qrcode',
                      cookieController.cookie);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationScreen()));
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

Future<int> postDiaryData(
  BuildContext context,
  File imageFile,
  String plant_name,
  String emotion,
  String title,
  String content,
  DateTime date,
  bool isPublic,
  String id,
  String cookie,
) async {
  final url = Uri.parse('https://iotvase.azurewebsites.net/green/diary/${id}');

  var request = http.MultipartRequest('POST', url);

  // Add form fields
  request.headers['Cookie'] = cookie;
  request.fields['id'] = 'qrcode';

  request.fields['plant_name'] = plant_name;
  request.fields['title'] = title;
  request.fields['date'] = date.toString();

  request.fields['emotion'] = emotion;
  request.fields['isPublic'] = isPublic.toString();
  request.fields['content'] = content;

  var imagePart = await http.MultipartFile.fromPath('image', imageFile.path);
  request.files.add(imagePart);
  var response = await request.send();

  // Handle the response
  if (response.statusCode == 200) {
    Navigator.pop(context, true);
    Navigator.pop(context, true);
    Navigator.pop(context, true);
    Navigator.pop(context, true);
    Navigator.pop(context, true);
    Navigator.pop(context, true);
    Navigator.pop(context, true);

    print('Response: ${await response.stream.bytesToString()}');
  } else {
    // Request failed, handle the error
    print(plant_name);
    print(emotion);
    print(title);
    print(content);
    print(date);
    print('Error: ${response.statusCode}');
  }
  return response.statusCode;
}
