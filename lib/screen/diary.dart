import 'package:flutter/material.dart';
import 'package:mygreen/utils.dart';

class DiaryPage extends StatefulWidget {
  //일기 제목
  final String title;
  //일기 내용
  final String content;
  //일기 날짜
  final String date;

  const DiaryPage({
    Key? key,
    required this.title,
    required this.content,
    required this.date,
  }) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

//일단 보기좋게 나열해놓음

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    //날짜 년 / 월 / 일 분리
    String dateString = widget.date.toString();
    DateTime dateTime = DateTime.parse(dateString.replaceAll('-', ''));
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;

    return Scaffold(
      appBar: AppBar(
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
                      '날짜 ; ${month}월 ${day}일',
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
              Wrap(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/image/test$index.png',
                      width: 100,
                      height: 100,
                    ),
                  );
                }),
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
            ],
          ),
        ),
      ),
    );
  }
}
