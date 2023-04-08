import 'package:flutter/material.dart';
import 'package:mygreen/utils.dart';

class DiaryPage extends StatefulWidget {
  //일기 제목
  final String title;
  //일기 내용
  final String content;
  const DiaryPage({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //Title Center로 설정
          title: Text(widget.title),

          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Text(widget.content),
          ),
        ));
  }
}
