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
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;

    // 색상 변환
    // Color convertColor =
    //     Color(int.parse("0xFF${widget.color}")); // 16진수 문자열을 Color로 변환

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('plant_name 의 다이어리'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 30),

            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(16.0), // Add padding as needed
                decoration: BoxDecoration(
                  color: Color.fromARGB(87, 211, 210, 210), // 배경색을 원하는 색상으로 설정
                  borderRadius: BorderRadius.circular(15.0), // 원하는 반지름으로 조절
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            DiaryEmotion(emotion: widget.emotion),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  0.3, // Set the width of the restricted area
                              child: const Text(
                                'title',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${year}.${month}.${day}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(right: 30.0), // 원하는 우측 여백 값을 설정
                          child: Image.asset(
                            'assets/image/test.png',
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${widget.content}',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Emotion
          ],
        ),
      ),
    );
  }
}
