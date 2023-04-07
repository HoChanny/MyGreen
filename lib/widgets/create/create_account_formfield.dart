import 'package:flutter/material.dart';

//  회원가입 폼
class MyTextFormField extends StatefulWidget {
  IconData icon;
  bool obscureText;
  final String hintText;
  //입력이 아무것도 없을때
  final String warningMessage1;

  //정규표현식이 틀렸을때
  final String warningMessage2;
  TextEditingController controller;

  final Function(String formValue) validValue;
  String formValue;

  MyTextFormField(
      {Key? key,
      required this.icon,
      required this.hintText,
      required this.obscureText,
      required this.warningMessage1,
      required this.warningMessage2,
      required this.controller,
      required this.validValue,
      required this.formValue})
      : super(key: key);

  _MyTextFormField createState() => _MyTextFormField();
}

class _MyTextFormField extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 20,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        focusColor: Colors.white,
        //add prefix icon
        prefixIcon: Icon(widget.icon, color: Colors.black),

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
          return widget.warningMessage1;
        } else if (widget.validValue(widget.formValue)) {
          return widget.warningMessage2;
        }

        return null;
      },
      onSaved: (value) {
        widget.formValue = value!;
      },
    );
  }
}
