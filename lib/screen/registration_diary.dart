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

import 'package:mygreen/widgets/diary/diary_form.dart';

import '../provider/global_state.dart';

class Registration_Diary extends StatefulWidget {
    final String id;

  const Registration_Diary(
      {required this.id,super.key});

  @override
  State<Registration_Diary> createState() => _Registration_DiaryState();
}

class _Registration_DiaryState extends State<Registration_Diary> {
  final formKey = GlobalKey<FormState>();
  final cookieController = Get.put(GlobalState());
  final profileController = Get.put(GlobalState());

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
  // 예시 데이터
  List<String> dropdownList = [];
  List<String> colorList = [];
  String selectedDropdownPlant = '';
  String color = '';
  Color convertColor = Colors.lightGreen;

  String image = '';
  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Color getColor(String rawColor) {
    RegExp regExp = RegExp(r'primary value: (Color\(.+?\))');

    Match? match = regExp.firstMatch(rawColor);
    String extractedColor = match?.group(1) ?? "";
    print(extractedColor);
    Color color = parseColor(extractedColor);
    return color;
  }

  Color parseColor(String colorString) {
    String hexColor = colorString.split('(0x')[1].split(')')[0];
    int value = int.parse(hexColor, radix: 16);
    return Color(value);
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
          colorList = jsonData.map((data) => data['color'] as String).toList();
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

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print(widget.id);
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
                            int index =
                                dropdownList.indexOf(selectedDropdownPlant);

                            color = colorList[index];

                            convertColor = getColor(color);
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
                  child: Center(
                    child: IconButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime.now(),
                        );

                        if (newDate == null) return;
                        setState(() => date = newDate);
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ),
                ),

                Center(
                    child: Text('${date.year}년 ${date.month}월 ${date.day}일')),
                //감정 선택
                Center(
                  child: Column(
                    children: [
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
                    child: ElevatedButton(
                  onPressed: () {
                    var result = postDiaryData(
                        context,
                        File(_pickedFile!.path),
                        widget.id,
                        selectedDropdownPlant,
                        selectedDropdownEmotion,
                        controllerTitle.text,
                        controllerContent.text,
                        date,
                        cookieController.cookie);
                    if (result == 200) {
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text('등록하기'),
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

  Future<int> postDiaryData(
    BuildContext context,
    File imageFile,
    String id,
    String dropdownValuePlant,
    String dropdownValueEmotion,
    String title,
    String content,
    DateTime date,
    String cookie,
  ) async {
    final url = Uri.parse('https://iotvase.azurewebsites.net/green/diary');

    var request = http.MultipartRequest('POST', url);

    // Add form fields
    request.headers['Cookie'] = cookie;
    request.fields['id'] = id;

    request.fields['plant_name'] = dropdownValuePlant;
    request.fields['title'] = title;
    request.fields['date'] = date.toString();

    request.fields['emotion'] = dropdownValueEmotion;
    request.fields['content'] = content;
    print(id);
    var imagePart = await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(imagePart);
    var response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      // Request successful, do something with the response

      // 새로운 이벤트 생성
      // Event newEvent = Event(
      //   dropdownValuePlant,
      //   title,
      //   dropdownValueEmotion,
      //   content,
      //   imagePart.toString(),
      // );

      // // 이벤트를 추가할 날짜
      // DateTime eventDate = DateTime(date.year, date.month, date.day);

      // // eventDate 키가 이미 존재하는지 확인
      // if (eventSource.containsKey(eventDate)) {
      //   // 이미 해당 날짜에 이벤트가 있는 경우, 기존 이벤트 목록에 새로운 이벤트를 추가
      //   eventSource[eventDate].add(newEvent);
      // } else {
      //   // 해당 날짜에 이벤트가 없는 경우, 새로운 이벤트 목록을 생성하여 추가
      //   eventSource[eventDate] = [newEvent];
      // }
      // //이벤트 추가 -> 정렬 -> 출력하기 로직
      // print(eventSource);
      Navigator.pop(context, true);
      Navigator.pop(context, true);

      print('Response: ${await response.stream.bytesToString()}');
    } else {
      // Request failed, handle the error
      print(dropdownValuePlant);
      print(dropdownValueEmotion);
      print(title);
      print(content);
      print(date);
      print('Error: ${response.statusCode}');
    }
    return response.statusCode;
  }

  //삭제로직
  Future<int> deleteDiaryData(BuildContext context, String cookie) async {
    final url = Uri.parse('https://iotvase.azurewebsites.net/green/diary/');

    var request = http.Request('DELETE', url);
    request.headers['Cookie'] = cookie;

    var response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      // 항목 삭제 성공
      Navigator.pop(context, true);
      print('Diary data deleted successfully');
    } else {
      // 항목 삭제 실패
      print('Failed to delete diary data. Error code: ${response.statusCode}');
    }

    return response.statusCode;
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

Color parseMaterialColor(String materialColorString) {
  String colorString = materialColorString
      .replaceAll('MaterialColor(primary value: Color(', '')
      .replaceAll(')', '');
  int value = int.parse(colorString, radix: 16);
  return Color(value);
}
