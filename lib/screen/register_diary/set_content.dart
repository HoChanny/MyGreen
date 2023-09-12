import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreen/provider/global_state.dart';
import 'package:mygreen/widgets/sign_in/left_align_text.dart';

import '../../widgets/diary/diary_form.dart';
import 'diary_complete_screen.dart';

class SetContentScreen extends StatefulWidget {
  SetContentScreen({Key? key}) : super(key: key);

  @override
  _SetContentScreenState createState() => _SetContentScreenState();
}

class _SetContentScreenState extends State<SetContentScreen> {
  final infoController = Get.put(GlobalState());

  final formKey = GlobalKey<FormState>();

  //컨트롤러 제목
  final TextEditingController controllerTitle = TextEditingController();
  String title = '';

  // 내용
  final TextEditingController controllerContent = TextEditingController();
  String content = '';
  @override
  Widget build(BuildContext context) {
    var verticalSize = MediaQuery.of(context).size.height;
    var horizontalSize = MediaQuery.of(context).size.width;
    final imageSize = MediaQuery.of(context).size.width / 3;

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
            LeftAlignText(content: '제목과 내용을 입력해주세요.'),
            SizedBox(
              height: verticalSize * 0.1,
            ),
            //일기 제목 작성하기
            Container(
              child: DiaryForm(
                maxLines: 1,
                hintText: '제목을 입력해주세요.',
                labelText: '제목',
                warningMessage: '위험',
                formValue: title,
                controller: controllerTitle,
              ),
            ),
            SizedBox(
              height: verticalSize * 0.05,
            ),
            //일기 내용 작성하기
            Container(
              child: DiaryForm(
                maxLines: 4,
                hintText: '내용을 입력해주세요.',
                labelText: '내용',
                warningMessage: '위험',
                formValue: content,
                controller: controllerContent,
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
                            builder: (context) => DiaryCompleteScreen()));
                  },
                  child: Text('다음')),
            )
          ],
        ),
      ),
    ));
  }
}
