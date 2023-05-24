import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mygreen/provider/global_state.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final cookieController = Get.put(GlobalState());
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
              height: 40,
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
                      selectImage(context);
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
                
                  var result =sendDataToServer(context, File(_pickedFile!.path), potName, properTemperature, wateringCycle, profileColor, cookieController.cookie);
                  if (result == 200){
                    Navigator.pop(context, true);
                  }
                  
                },
                child: Text('완료')),

                TextButton(onPressed: (){
                  print(cookieController.cookie);
                }, child: Text("쿠키확인"))
          ],
        ),
      ),
    );
  }

  selectImage(BuildContext context) {
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

}



Future<int> sendDataToServer(BuildContext context, File imageFile, String potName, String properTemperature, String wateringCycle, Color profileColor, String cookie) async {
  final url = Uri.parse('https://iotvase.azurewebsites.net/green');

  var request = http.MultipartRequest('POST', url);

  request.headers['Cookie'] = cookie;

  request.fields['plant_name'] = potName;
  request.fields['temperature'] = properTemperature;
  request.fields['wateringCycle'] = wateringCycle;
  request.fields['color'] = profileColor.toString();

  var imagePart = await http.MultipartFile.fromPath('profile', imageFile.path);
  request.files.add(imagePart);

  var response = await request.send();
  if (response.statusCode == 200) {
    print('Data sent successfully');
    Navigator.pop(context, true);
  } else {
    print('Failed to send data. Error code: ${response.statusCode}');
  }

  return response.statusCode;
}
