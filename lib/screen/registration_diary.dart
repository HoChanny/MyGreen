import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

import '../provider/global_state.dart';

class Registration_Diary extends StatefulWidget {
  const Registration_Diary({Key? key}) : super(key: key);

  @override
  State<Registration_Diary> createState() => _Registration_DiaryState();
}

class _Registration_DiaryState extends State<Registration_Diary> {
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
  final profileController = Get.put(GlobalState());
  // 예시 데이터
  List<String> dropdownList = [];
  String selectedDropdownPlant = '';
  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final url = Uri.parse('https://iotvase.azurewebsites.net/green');
      final response =
          await http.get(url, headers: {'Cookie': profileController.cookie});

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          dropdownList =
              jsonData.map((data) => data['plant_name'] as String).toList();
          selectedDropdownPlant = dropdownList[0];
        });
      } else {
        print('Failed to fetch data. Error code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error while fetching data: $error');
    }
    if (mounted) {
      setState(() {});
    }
  }

  void refreshData() {
    fetchDataFromServer();
  }

  //드롭다운 감정 메뉴
  List<String> dropdownListEmotion = ['😡', '😠', '😮', '😀', '😍'];
  String selectedDropdownEmotion = '😮';

  DateTime date = DateTime(2000, 01, 01);

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 3;
    print('dropdownList : ${dropdownList}');
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
                //aas
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
                        items: dropdownList.map((dynamic item) {
                          return DropdownMenuItem<dynamic>(
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
                Container(
                  margin: const EdgeInsets.all(18.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // Set margin for all sides
                      children: [
                        const Icon(Icons.cake),
                        Text(
                          '${date.year}년 ${date.month}월 ${date.day}일',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(1900),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );

                            if (newDate == null) return;
                            setState(() => date = newDate);
                            print(DateTime.now());
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ]),
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
                      date: date,
                      postDiaryData: postDiaryData),
                ),
                Center(
                    child: ElevatedButton(
                  child: Text('a'),
                  onPressed: () {},
                )),
              ],
            ),
          ),
        ),
      ),
    );
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
      DateTime date) async {
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
      // 새로운 이벤트 생성
      Event newEvent = Event(
        dropdownValuePlant,
        title,
        dropdownValueEmotion,
        'FF0000',
        content,
      );

      // 이벤트를 추가할 날짜
      DateTime eventDate = DateTime(date.year, date.month, date.day);

      // eventDate 키가 이미 존재하는지 확인
      if (eventSource.containsKey(eventDate)) {
        // 이미 해당 날짜에 이벤트가 있는 경우, 기존 이벤트 목록에 새로운 이벤트를 추가
        eventSource[eventDate].add(newEvent);
      } else {
        // 해당 날짜에 이벤트가 없는 경우, 새로운 이벤트 목록을 생성하여 추가
        eventSource[eventDate] = [newEvent];
      }
      //이벤트 추가 -> 정렬 -> 출력하기 로직
      print(eventSource);
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

Future<void> getDataFromServer(String cookie) async {
  final url = Uri.parse('https://iotvase.azurewebsites.net/green');

  // Send GET request to server
  final response = await http.get(url, headers: {'Cookie': cookie});

  if (response.statusCode == 200) {
    // Parse the response
    final data = response.body;
    // Process the data as needed
    print('Received data: $data');
  } else {
    print('Failed to get data. Error code: ${response.statusCode}');
  }
}
