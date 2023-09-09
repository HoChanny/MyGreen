import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreen/provider/global_state.dart';
import 'package:mygreen/screen/sign_up/set_email_screen.dart';
import 'package:mygreen/widgets/sign_in/left_align_text.dart';
import 'package:mygreen/screen/sign_up/set_password_screen.dart';

class SetNicknameScreen extends StatelessWidget {
  SetNicknameScreen({super.key});

  final infoController = Get.put(GlobalState());

  final formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var verticalSize = MediaQuery.of(context).size.height;
    var horizontalSize = MediaQuery.of(context).size.width;
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
            LeftAlignText(content: '사용하실 닉네임을 입력해주세요'),
            SizedBox(
              height: verticalSize * 0.1,
            ),
            Row(
              children: [
                Expanded(
                    child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: idController,
                          decoration: InputDecoration(hintText: 'ㄹㅇㄴㅁㄹㄴ'),
                        ))),
                ElevatedButton(onPressed: (){

                }, child: Text('중복확인'))
              ],
            ),
            SizedBox(height: verticalSize*0.05,),
            Container(
              width: horizontalSize*0.9 ,
              child: ElevatedButton(onPressed: (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetEmailScreen()));
              }, child: Text('다음')),
            )
            
          ],
        ),
      ),
    ));
  }
}
