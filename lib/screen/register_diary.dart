import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mygreen/utils.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:mygreen/widgets/diary/diary_datePicker.dart';
import 'package:mygreen/widgets/diary/diary_dropdownMenu.dart';
import 'package:mygreen/widgets/diary/diary_form.dart';
import 'package:mygreen/widgets/diary/diary_submitButton.dart';

class Register_Diary extends StatefulWidget {
  const Register_Diary({Key? key}) : super(key: key);

  @override
  State<Register_Diary> createState() => _Register_DiaryState();
}

class _Register_DiaryState extends State<Register_Diary> {
  String handleDropdownValue(String value) {
    // 선택된 값(value)을 이용하여 원하는 동작을 수행합니다.
    return value;
    // 여기에 처리 로직을 추가하세요.
  }

  final formKey = GlobalKey<FormState>();

  //사진 선택하기
  XFile? _pickedFile;
  var potProfile = Map();

  //컨트롤러 제목
  final TextEditingController controllerTitle = TextEditingController();
  String title = '';

  // 내용
  final TextEditingController controllerContent = TextEditingController();
  String content = '';

  //날짜 선택하기

  String _selectedDate = (DateFormat.yMd()).format(DateTime.now());

  //드롭다운 식물 메뉴
  List<String> dropdownListPlant = ['먀몸미', '설이'];
  String selectedDropdownPlant = '먀몸미';

  //드롭다운 감정 메뉴
  List<String> dropdownListEmotion = ['😡', '😠', '😮', '😀', '😍'];
  String selectedDropdownEmotion = '😮';

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 3;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('일기 쓰기'),
          centerTitle: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              key: formKey,
              children: <Widget>[
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 10),
                    ),
                    width: imageSize,
                    height: imageSize,
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
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(File(_pickedFile!.path)),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ) //Image.file(File(_pickedFile!.path))
                          : Center(
                              child: Icon(
                                const IconData(0xee39,
                                    fontFamily: 'MaterialIcons'),
                                size: imageSize * 0.4,
                              ),
                            ),
                    ),
                  ),
                ),
                //일기 쓸 식물 선택
                Center(
                  child: Column(
                    children: [
                      // Step 2.
                      DropdownButton(
                        value: selectedDropdownPlant,
                        items: dropdownListPlant.map((String item) {
                          return DropdownMenuItem<String>(
                            child: Text('$item'),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            selectedDropdownPlant = value;
                          });
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        underline: Container(
                          height: 0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                //일기 제목 작성하기
                Container(
                  margin: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  child: DiaryForm(
                    maxLines: 1,
                    hintText: '제목을 입력해주세요.',
                    labelText: '제목',
                    warningMessage: '위험',
                    formValue: title,
                    controller: controllerTitle,
                  ),
                ),
                //일기 내용 작성하기
                Container(
                  margin: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  child: DiaryForm(
                    maxLines: 4,
                    hintText: '내용을 입력해주세요.',
                    labelText: '내용',
                    warningMessage: '위험',
                    formValue: content,
                    controller: controllerContent,
                  ),
                ),

                //날짜 선택
                Center(
                  child: Container(
                    padding: EdgeInsets.all(24.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            _selectedDate,
                            style: TextStyle(fontSize: 24),
                          ),
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () => _selectDate(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Center(child: Text('${_selectedDate}')),
//감정 선택
                Center(
                  child: Column(
                    children: [
                      // Step 2.
                      DropdownButton(
                        value: selectedDropdownEmotion,
                        items: dropdownListEmotion.map((String item) {
                          return DropdownMenuItem<String>(
                            child: Text('$item'),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            selectedDropdownEmotion = value;
                          });
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        underline: Container(
                          height: 0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                //제출 버튼
                Center(
                  child: DiarySubmitButton(
                      pickedFile: _pickedFile,
                      dropdownValuePlant: selectedDropdownPlant,
                      dropdownValueEmotion: selectedDropdownEmotion,
                      title: controllerTitle,
                      content: controllerContent,
                      date: _selectedDate,
                      postRequest: postDiaryData),
                ),
                Center(
                    child: ElevatedButton(
                  child: Text('a'),
                  onPressed: () {
                    if (eventSource.keys == _selectedDate) {
                      print('${eventSource.keys} ${_selectedDate}');
                    } else {
                      print('${eventSource.keys} ${_selectedDate}');
                    }
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDropdownValueChanged(String value) {
    // Handle the updated dropdown value here
    print(value);
    // You can perform any other actions with the updated value
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
                child: const Text('사진 촬영')),
            TextButton(
                onPressed: () {
                  _getPhotoLibraryImage();
                },
                child: const Text('앨범에서 선택')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('완료')),
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

  Future<void> postDiaryData(
      XFile? pickedFile,
      String dropdownValuePlant,
      String dropdownValueEmotion,
      String title,
      String content,
      String date) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://iotvase.azurewebsites.net/green/diary'),
    );

    // Add image file
    if (pickedFile != null) {
      var file = await http.MultipartFile.fromPath('image', pickedFile.path);
      request.files.add(file);
    }

    // Add form fields
    request.fields['name'] = dropdownValuePlant;
    request.fields['emotion'] = dropdownValueEmotion;
    request.fields['title'] = title;
    request.fields['content'] = content;
    request.fields['date'] = date.toString();

    // Send the HTTP request
    var response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      // Request successful, do something with the response
      print('Response: ${await response.stream.bytesToString()}');
    } else {
      // Request failed, handle the error
      print('Error: ${response.statusCode}');
    }
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selected != null) {
      setState(() {
        _selectedDate = (DateFormat.yMd()).format(selected);
      });
    }
  }
}
