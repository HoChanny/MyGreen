import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DiarySubmitButton extends StatefulWidget {

  XFile? pickedFile;
  String dropdownValue;
  TextEditingController title;
  TextEditingController content;
  DateTime date;
  final Future<void> Function(XFile? pickedFile, String dropdownValue, String title, String content , DateTime date) postDiaryData;

  DiarySubmitButton({
    Key? key,
    required this.pickedFile,
    required this.dropdownValue,
    required this.title,
    required this.content,
    required this.date,
    required this.postDiaryData,
  }) : super(key: key);  
  
  @override
  State<DiarySubmitButton> createState() => _DiarySubmitButtonState();
}
class _DiarySubmitButtonState extends State<DiarySubmitButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text('일기 작성 하기'),
        onPressed: (){
          if (widget.pickedFile != null &&
              widget.dropdownValue != null &&
              widget.title.text.isNotEmpty &&
              widget.content.text.isNotEmpty &&
              widget.date != null) {
          print('${widget.pickedFile!.path} , ${widget.dropdownValue} , ${widget.title.text} , ${widget.content.text} , ${widget.date}');
          widget.postDiaryData(widget.pickedFile,widget.dropdownValue,widget.title.text,widget.content.text,widget.date);
          }
        }
      
    );
  }
}