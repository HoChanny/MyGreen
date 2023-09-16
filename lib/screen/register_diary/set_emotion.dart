import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreen/provider/resgister_diary_state.dart';
import 'package:mygreen/screen/register_diary/set_image.dart';
import 'package:mygreen/widgets/sign_in/left_align_text.dart';

class SetEmotionScreen extends StatelessWidget {
  SetEmotionScreen({super.key});

  final diaryData = Get.find<DiaryState>();

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
            LeftAlignText(content: '오늘 감정을 표현해주세요.'),
            SizedBox(
              height: verticalSize * 0.2,
            ),
            Row(
              children: [
                Container(
                  width: horizontalSize * 0.15,
                  height: horizontalSize * 0.15,
                  margin: EdgeInsets.all(
                      horizontalSize * 0.011), // Set the desired margin
                  child: ElevatedButton(
                    onPressed: () {
                      diaryData.setEmotion('😡');

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetImageScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      '😡',
                      style:
                          TextStyle(fontSize: 24), // Set the desired font size
                    ),
                  ),
                ),
                Container(
                  width: horizontalSize * 0.15,
                  height: horizontalSize * 0.15,
                  margin: EdgeInsets.all(
                      horizontalSize * 0.011), // Set the desired margin
                  child: Padding(
                    padding: const EdgeInsets.all(
                        0.0), // Adjust the padding as needed
                    child: ElevatedButton(
                      onPressed: () {
                        diaryData.setEmotion('😠');

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetImageScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        '😠',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: horizontalSize * 0.15,
                  height: horizontalSize * 0.15,
                  margin: EdgeInsets.all(
                      horizontalSize * 0.011), // Set the desired margin
                  child: Padding(
                    padding: const EdgeInsets.all(
                        0.0), // Adjust the padding as needed
                    child: ElevatedButton(
                      onPressed: () {
                        diaryData.setEmotion('😮');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetImageScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        '😮',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: horizontalSize * 0.15,
                  height: horizontalSize * 0.15,
                  margin: EdgeInsets.all(
                      horizontalSize * 0.011), // Set the desired margin
                  child: Padding(
                    padding: const EdgeInsets.all(
                        0.0), // Adjust the padding as needed
                    child: ElevatedButton(
                      onPressed: () {
                        diaryData.setEmotion('😀');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetImageScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        '😀',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: horizontalSize * 0.15,
                  height: horizontalSize * 0.15,
                  margin: EdgeInsets.all(
                      horizontalSize * 0.011), // Set the desired margin
                  child: Padding(
                    padding: const EdgeInsets.all(
                        0.0), // Adjust the padding as needed
                    child: ElevatedButton(
                      onPressed: () {
                        diaryData.setEmotion('😍');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetImageScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        '😍',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: verticalSize * 0.05,
            ),
          ],
        ),
      ),
    ));
  }
}
