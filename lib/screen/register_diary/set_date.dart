import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreen/provider/resgister_diary_state.dart';
import 'package:mygreen/screen/register_diary/set_emotion.dart';
import 'package:mygreen/widgets/sign_in/left_align_text.dart';

class SetDateScreen extends StatefulWidget {
  SetDateScreen({Key? key}) : super(key: key);

  @override
  _SetDateScreenState createState() => _SetDateScreenState();
}

class _SetDateScreenState extends State<SetDateScreen> {
  final diaryData = Get.put(DiaryState());

  final formKey = GlobalKey<FormState>();

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var verticalSize = MediaQuery.of(context).size.height;
    var horizontalSize = MediaQuery.of(context).size.width;

// date 변수에서 선택한 날짜 가져오기
    int selectedYear = date.year;
    int selectedMonth = date.month;
    int selectedDay = date.day;

    return Scaffold(
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus(); // 포커스 제거
        },
        child: Container(
          padding: EdgeInsets.all(verticalSize * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: verticalSize * 0.1,
              ),
              LeftAlignText(content: '날짜를 선택해주세요.'),
              SizedBox(
                height: verticalSize * 0.2,
              ),
              Center(
                child: Text(
                  '${date.year}년 ${date.month}월 ${date.day}일',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(
                height: verticalSize * 0.02,
              ),
              Container(
                margin: const EdgeInsets.all(18.0),
                child: Center(
                  child: Container(
                    width: 48.0, // Adjust the width as needed
                    height: 48.0, // Adjust the height as needed
                    child: IconButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime.now(),
                        );

                        if (newDate == null) return;
                        setState(() => date = newDate);
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        size: 32.0, // Adjust the size as needed
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: verticalSize * 0.05,
              ),
              Container(
                width: horizontalSize * 0.9,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetEmotionScreen()));

                      DateTime newDateTime = DateTime(date.year, date.month, date.day);
String formattedDateTimeStr = newDateTime.toIso8601String();

                      diaryData.setDate(formattedDateTimeStr);
                    },
                    child: Text('다음')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
