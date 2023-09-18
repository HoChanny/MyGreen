import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreen/provider/global_state.dart';
import 'package:mygreen/screen/sign_up/set_birth_screen.dart';
import 'package:mygreen/screen/sign_up/set_nickname_screen.dart';
import 'package:mygreen/widgets/sign_in/left_align_text.dart';

class SetPasswordScreen extends StatelessWidget {
  SetPasswordScreen({super.key});

  final infoController = Get.put(GlobalState());

  final formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var verticalSize = MediaQuery.of(context).size.height;
    var horizontalSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('회원가입'),),
        body: InkWell(
      onTap: () {
        FocusScope.of(context).unfocus(); // 포커스 제거
      },
      child: Container(
        padding: EdgeInsets.all(verticalSize * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            LeftAlignText(content: '사용하실 비밀번호를 입력해주세요'),
            SizedBox(
              height: verticalSize * 0.1,
            ),
            LeftAlignText(content: '비밀번호 입력'),
            SizedBox(height: verticalSize*0.03,),
            Form(
                //key: formKey,
                child: TextFormField(
                  controller: idController,
                  decoration: InputDecoration(hintText: '비밀번호를 입력해주세요'),
                )),
            SizedBox(height: verticalSize*0.06,),
            LeftAlignText(content: '비밀번호 확인'),
            SizedBox(height: verticalSize*0.03,),
            Form(
                key: formKey,
                child: TextFormField(
                  controller: idController,
                  decoration: InputDecoration(hintText: '한번 더 입력해주세요'),
                )),
            SizedBox(
              height: verticalSize * 0.05,
            ),
            Container(
              width: horizontalSize * 0.9,
              child: ElevatedButton(onPressed: () {
                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetNicknameScreen()));
              }, child: Text('다음')),
            )
          ],
        ),
      ),
    ));
  }
}
