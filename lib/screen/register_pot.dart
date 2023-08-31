import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Register_Pot extends StatefulWidget {
  const Register_Pot({Key? key}) : super(key: key);

  @override
  State<Register_Pot> createState() => _Register_PotState();
}

class _Register_PotState extends State<Register_Pot> {
  XFile? _pickedFile;
  Color profileColor = Colors.lightGreen;
  var potProfile = Map();
  var potName;
  var properTemperature;
  var wateringCycle;

  final _nameFormKey = GlobalKey<FormState>();
  final _tempFormKey = GlobalKey<FormState>();
  final _waterFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 3;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('화분 등록'),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 10, color: profileColor),
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
                            const IconData(0xee39, fontFamily: 'MaterialIcons'),
                            size: imageSize * 0.4,
                          ))),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: profileColor,
                ),
                onPressed: () {
                  _selectColor();
                },
                child: const Text("프로필색상 선택")),
            Form(
                key: _nameFormKey,
                child: TextFormField(
                  maxLength: 8,
                  decoration: const InputDecoration(
                      //counterStyle: TextStyle(),
                      labelText: '화분이름',
                      hintText: '8글자 이내'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '화분 이름은 필수 항목입니다.';
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      potName = value;
                    });
                  },
                )),
            Form(
                key: _waterFormKey,
                child: TextFormField(
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      counterText: "",
                      labelText: '물주는 주기',
                      hintText: '물주는 주기(일)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '물주는 주기는 필수 항목입니다.';
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      wateringCycle = value;
                    });
                  },
                )),
            Form(
                key: _tempFormKey,
                child: TextFormField(
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      counterText: "",
                      labelText: '적정 온도',
                      hintText: '적정 온도(°C)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '적정 온도는 필수 항목입니다.';
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      properTemperature = value;
                    });
                  },
                )),
            ElevatedButton(
                onPressed: () {
                  final nameFormKeyState = _nameFormKey.currentState;
                  final waterFormKeyState = _waterFormKey.currentState;
                  final tempFormKeyState = _tempFormKey.currentState;
                  if (nameFormKeyState!.validate()) {
                    nameFormKeyState.save();
                  }
                  if (waterFormKeyState!.validate()) {
                    waterFormKeyState.save();
                  }
                  if (tempFormKeyState!.validate()) {
                    tempFormKeyState.save();
                  }
                  potProfile['name'] = potName;
                  potProfile['image'] = _pickedFile;
                  potProfile['color'] = profileColor;
                  potProfile['temperature'] = properTemperature;
                  potProfile['wateringCycle'] = wateringCycle;

                  sendDataToServer(_pickedFile, potName, properTemperature, wateringCycle);
                  Navigator.pop(context);
                },
                child: Text('완료')),
          ],
        ),
      ),
    );
  }

  selectImage() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('프로필 사진 설정'),
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

  _selectColor() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('프로필색상 설정'),
            content: SingleChildScrollView(
              child: BlockPicker(
                  pickerColor: profileColor,
                  onColorChanged: (Color color) {
                    setState(() {
                      profileColor = color;
                    });
                  }),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('완료'))
            ],
          );
        });
  }

  void sendDataToServer(XFile? pickedFile, String potName,
      String properTemperature, String wateringCycle) async {
    var url = Uri.parse('https://green');
    var request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('image', pickedFile!.path));
    request.fields['name'] = potName;
    request.fields['temperature'] = properTemperature;
    request.fields['watering_cycle'] = wateringCycle;
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Success!');
    } else {
      print('Failed with status ${response.statusCode}');
    }
  }
}
