import 'package:flutter/material.dart';

import 'package:mygreen/widgets/diary/diary_emotion.dart';

class DiaryPage extends StatefulWidget {
  //식물 이름
  final String plant_name;
  //일기 제목
  final String title;
  //일기 날짜
  final String date;
  //감정
  final int emotion;
  //색상
  final String color;
  //일기 내용
  final String content;

  const DiaryPage({
    Key? key,
    required this.plant_name,
    required this.title,
    required this.date,
    required this.emotion,
    required this.color,
    required this.content,
  }) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

//일단 보기좋게 나열해놓음

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    //날짜 월 / 일 분리
    String dateString = widget.date.toString();
    DateTime dateTime = DateTime.parse(dateString.replaceAll('-', ''));
    int month = dateTime.month;
    int day = dateTime.day;

    // 색상 변환
    // Color convertColor =
    //     Color(int.parse("0xFF${widget.color}")); // 16진수 문자열을 Color로 변환

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        //Title Center로 설정
        title: Text(widget.title),
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
                    Container(
                      child: Image.asset(
                        'assets/image/test.png',
                        width: MediaQuery.of(context).size.height * 0.4,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                  ],
                ),
              ),

              // 날짜 & 이모지를 포함한 컨테이너
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 100,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Row(
                  children: [
                    Text(
                      ' ${month}월 ${day}일 ',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 14, 14, 14),
                        fontFamily: '',
                      ),
                    ),
                    DiaryEmotion(emotion: widget.emotion),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Color.fromARGB(87, 211, 210, 210), // 배경색을 원하는 색상으로 설정
                  borderRadius: BorderRadius.circular(10.0), // 원하는 반지름으로 조절
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0), // 필요에 따라 패딩 값을 조정
                  child: Text(
                    '${widget.content}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: '',
                    ),
                  ),
                ),
              ),

              //감정
            ],
          ),
        ),
      ),
    );
  }
}
