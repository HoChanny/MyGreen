import 'package:flutter/material.dart';
import 'package:mygreen/utils.dart';

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
    Color convertColor =
        Color(int.parse("0xFF${widget.color}")); // 16진수 문자열을 Color로 변환

    print(convertColor);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: convertColor,
        //Title Center로 설정
        title: Text('Diary'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //이름
              Container(
                child: Text('${widget.plant_name}'),
              ),
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
                        fontSize: 20,
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
                child: Image.asset(
                  'assets/image/test.png',
                  width: 100,
                  height: 100,
                ),
              ),
              //제목
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Text('제목 : ${widget.title}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: '',
                    )),
              ),
              // 내용
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
                child: Text(
                  '내용 : ${widget.content}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: '',
                  ),
                ),
              ),
              //감정
              Container(
                child: Text('감정 : ${widget.emotion}'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
