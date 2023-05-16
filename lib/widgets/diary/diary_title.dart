import 'package:flutter/material.dart';

class DiaryTitle extends StatefulWidget {

  final String hintText;
  final String warningMessage;
  String formValue;
  TextEditingController controller;

  DiaryTitle(
      {Key? key,
      required this.hintText,
      required this.warningMessage,
      required this.formValue,
      required this.controller})
      : super(key: key);
    State<DiaryTitle> createState() => _DiaryTitleState();
}

class _DiaryTitleState extends State<DiaryTitle> {
@override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 20,
      decoration: InputDecoration(
        focusColor: Colors.white,
        //add prefix icon

        hintText: widget.hintText,

        //default border
        enabledBorder: UnderlineInputBorder(
            borderSide:
                const BorderSide(width: 2, color: Colors.black), //<-- SEE HERE
            borderRadius: BorderRadius.circular(0.0)),

        //focus border
        focusedBorder: UnderlineInputBorder(
            //<-- SEE HERE
            borderSide: const BorderSide(width: 3, color: Colors.greenAccent),
            borderRadius: BorderRadius.circular(0.0)),
      ),
      controller: widget.controller,
      validator: (value) {
        if (value!.isEmpty) {
          return widget.warningMessage;
        }
        return null;
      },
      onSaved: (value) {
        widget.formValue = value!;
        print('formValue : ${widget.formValue}');
      },
    );
  }

  }