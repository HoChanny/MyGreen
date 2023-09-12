import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreen/provider/global_state.dart';
import 'package:mygreen/screen/register_diary/set_date.dart';

import 'package:mygreen/widgets/sign_in/left_align_text.dart';

class SetPotScreen extends StatelessWidget {
  SetPotScreen({super.key});

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
            LeftAlignText(content: '화분을 선택해주세요.'),
            SizedBox(
              height: verticalSize * 0.05,
            ),
            ElevatedButton(
              onPressed: () {
                print('5');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SetDateScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                '😍',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
