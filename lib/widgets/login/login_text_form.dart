import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyTextFormField extends StatefulWidget {
  IconData icon;
  final String hintText;

  final String warningMessage;
  bool obscureText;

  String formValue;
  TextEditingController controller;

  MyTextFormField(
      {Key? key,
      required this.icon,
      required this.hintText,
      required this.warningMessage,
      required this.obscureText,
      required this.formValue,
      required this.controller})
      : super(key: key);

  _MyTextFormField createState() => _MyTextFormField();
}

class _MyTextFormField extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 20,
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
          return widget.warningMessage;
        }
        return null;
      },
      onSaved: (value) {
        widget.formValue = value!;
        //print('formValue : ${widget.formValue}');
      },
    );
  }
}