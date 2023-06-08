import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mygreen/utils.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mygreen/screen/view_my_pot_screen.dart';
import '../provider/global_state.dart';

class DiaryPage extends StatefulWidget {

  final String id;
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

  final MemoryImage image;

  const DiaryPage(
      {Key? key,
      required this.id,
      required this.plant_name,
      required this.title,
      required this.date,
      required this.emotion,
      required this.color,
      required this.content,
      required this.image})
      : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

//일단 보기좋게 나열해놓음

class _DiaryPageState extends State<DiaryPage> {
  final cookieController = Get.put(GlobalState());
  final profileController = Get.put(GlobalState());

  @override
  void initState() {
    super.initState();
  }



  Widget build(BuildContext context) {

    //날짜 월 / 일 분리
    String dateString = widget.date.toString();
    DateTime dateTime = DateTime.parse(dateString.replaceAll('-', ''));
    int month = dateTime.month;
    int day = dateTime.day;

    print(widget.id );
    print(widget.date );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        //Title Center로 설정
        title: Text('Diary'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //날짜
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' ${month}월 ${day}일',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: '',
                      ),
                    ),
                  ],
                ),
              ),
              //이미지 -> widget값을 받아와서 뿌려야할듯.
              Container(
                child: CircleAvatar(
                  backgroundImage: widget.image,
                  radius: 50,
                ),
              ),
              //이름
              Container(
                child: Text('${widget.plant_name}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: '',
                      ),),
              ),
              //제목
              Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // Set as a fraction of the screen width
                height: 100,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Text(
                  '${widget.title}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: '',
                  ),
                ),
              ),
              // 내용
              Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // Set as a fraction of the screen width
                height: 100,

                child: Text(
                  '${widget.content}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: '',
                  ),
                ),
              ),
              //감정
              Container(
                child: Text(
                  widget.emotion,
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                    fontFamily: '',
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: const Text('삭제하기'),
                  onPressed: () {
                    print(widget.date.toString());
                    deleteDataToServer(context, widget.id, widget.date.toString(), cookieController.cookie);
                    
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<http.Response> deleteDataToServer(
  BuildContext context,
  String id,
  String date,
  String cookie,
) async {
  final url = Uri.parse('https://iotvase.azurewebsites.net/green/diary');

  final Map<String, dynamic> data = {
    "id": id,
    "date": date,
  };

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Cookie': cookie, // Include the 'Cookie' header with the cookie value
    },
    body: json.encode(data),
  );

  if (response.statusCode == 200) {
    Navigator.pop(context, true);
  } else {
    print('Failed to send data. Error code: ${response.statusCode}');
  }

  return response;
}