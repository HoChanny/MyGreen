import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  XFile? _pickedFile;
  Color profileColor = Colors.lightGreen;
  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 3;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Example1'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20,),
            if (_pickedFile == null)
              Container(
                constraints: BoxConstraints(
                  minHeight: _imageSize,
                  minWidth: _imageSize,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 10, color: profileColor),
                  ),
                child: GestureDetector(
                  onTap: () {
                    selectImage();
                  },
                  child: Center(
                    child: Icon(IconData(0xee39, fontFamily: 'MaterialIcons'),
                    size: _imageSize*0.4,)
                  ),
                ),
              )
            else
              Center(
                child: Container(
                  width: _imageSize,
                  height: _imageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 10, color: profileColor),
                    image: DecorationImage(
                        image: FileImage(File(_pickedFile!.path)),
                        fit: BoxFit.cover),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      selectImage();
                    },
                  ),
                ),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: profileColor,
              ),
              onPressed: (){
              _selectColor();
            }, child: Text("프로필색상 선택"))
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
          title: Text('프로필 사진 설정'),
          content: Text('사진을 촬영하거나 앨범에서 선택해 주세요.'),
          actions: [
            TextButton(onPressed: (){
              _getCameraImage();
            }, child: Text('사진 촬영')),
            TextButton(onPressed: (){
              _getPhotoLibraryImage();
            }, child: Text('앨범에서 선택')),
            
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

  _selectColor(){
    return showDialog(
      context: context, 
      builder: (context){
       return AlertDialog(
          title: Text('프로필색상 설정'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: profileColor, 
              onColorChanged: (Color color){
                setState(() {
                  profileColor = color;
                });
              }),
          ),
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('완료'))
          ],
        );
      });
  }
}

