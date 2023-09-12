import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreen/provider/global_state.dart';
import 'package:mygreen/screen/register_diary/set_content.dart';
import 'package:mygreen/widgets/sign_in/left_align_text.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class SetImageScreen extends StatefulWidget {
  SetImageScreen({Key? key}) : super(key: key);

  @override
  _SetImageScreenState createState() => _SetImageScreenState();
}

class _SetImageScreenState extends State<SetImageScreen> {
  final infoController = Get.put(GlobalState());

  final formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();

  // 이미지 선택
  XFile? _pickedFile;
  var potProfile = Map();

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
            LeftAlignText(content: '사진을 등록해주세요.'),
            SizedBox(
              height: verticalSize * 0.1,
            ),
            Center(
              child: Container(
                width: verticalSize,
                height: horizontalSize,
                child: GestureDetector(
                  onTap: () {
                    Permission.camera.request();
                    Permission.photos.request();
                    selectImage();
                  },
                  child: _pickedFile != null
                      ? Center(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(File(_pickedFile!.path)),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ) //Image.file(File(_pickedFile!.path))
                      : Center(
                          child: Icon(
                            const IconData(0xee39, fontFamily: 'MaterialIcons'),
                            size: imageSize,
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
                            builder: (context) => SetContentScreen()));
                  },
                  child: Text('다음')),
            )
          ],
        ),
      ),
    ));
  }

  selectImage() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('일기 사진 설정'),
          content: const Text('사진을 촬영하거나 앨범에서 선택해 주세요.'),
          actions: [
            TextButton(
              onPressed: () {
                _getCameraImage();
              },
              child: const Text('사진 촬영'),
            ),
            TextButton(
              onPressed: () {
                _getPhotoLibraryImage();
              },
              child: const Text('앨범에서 선택'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('완료'),
            ),
          ],
        );
      },
    );
  }

  _getCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }
}
