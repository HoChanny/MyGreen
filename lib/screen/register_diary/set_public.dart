import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreen/provider/resgister_diary_state.dart';
import 'package:mygreen/screen/register_diary/set_date.dart';
import 'package:mygreen/screen/register_diary/set_emotion.dart';
import 'package:mygreen/widgets/sign_in/left_align_text.dart';

class SetPublicScreen extends StatefulWidget {
  SetPublicScreen({Key? key}) : super(key: key);

  @override
  _SetPublicScreenState createState() => _SetPublicScreenState();
}

class _SetPublicScreenState extends State<SetPublicScreen> {
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
              LeftAlignText(content: '일기를 공개하시겠습니까 ? '),
              SizedBox(
                height: verticalSize * 0.2,
              ),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 버튼 간의 간격을 균등하게 설정
  children: [
    ElevatedButton(
      onPressed: () {
        diaryData.setPublic(true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetDateScreen(),
          ),
        );
      },
      child: Text('예'),
    ),
    ElevatedButton(
      onPressed: () {
        diaryData.setPublic(false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetDateScreen(),
          ),
        );
      },
      child: Text('아니오'),
    ),
  ],
)
              
                          ],
          ),
        ),
      ),
    );
  }
}
