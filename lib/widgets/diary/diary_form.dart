import 'package:flutter/material.dart';

class DiaryForm extends StatefulWidget {
  final int maxLines;

  final String hintText;
  final String labelText;

  final String warningMessage;
  String formValue;
  TextEditingController controller;

  DiaryForm(
      {Key? key,
      required this.maxLines,
      required this.hintText,
      required this.labelText,
      required this.warningMessage,
      required this.formValue,
      required this.controller})
      : super(key: key);
  State<DiaryForm> createState() => _DiaryFormState();
}

class _DiaryFormState extends State<DiaryForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 10 * widget.maxLines,

      //입력칸 늘리기
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusColor: Colors.white,
        //add prefix icon

        hintText: widget.hintText,
        labelText: widget.labelText,

        //default border
        enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 2, color: Colors.black), //<-- SEE HERE
            borderRadius: BorderRadius.circular(10.0)),

        //focus border
        focusedBorder: OutlineInputBorder(
            //<-- SEE HERE
            borderSide: const BorderSide(width: 3, color: Colors.greenAccent),
            borderRadius: BorderRadius.circular(10.0)),
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
