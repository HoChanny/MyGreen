import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreen/provider/global_state.dart';
import 'package:mygreen/widgets/sign_in/left_align_text.dart';
import 'package:mygreen/screen/sign_up/set_password_screen.dart';

class SetIdScreen extends StatelessWidget {
  SetIdScreen({super.key});

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
            
            LeftAlignText(content: '사용하실 아이디를 입력해주세요'),
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
                          decoration: InputDecoration(hintText: '아이디를 입력해주세요'),
                        ))),
                // ElevatedButton(onPressed: (){

                // }, child: Text('중복확인'))
              ],
            ),
            SizedBox(height: verticalSize*0.05,),
            Container(
              width: horizontalSize*0.9 ,
              child: ElevatedButton(onPressed: (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetPasswordScreen()));
              }, child: Text('다음')),
            )
            
          ],
        ),
      ),
    ));
  }
}
