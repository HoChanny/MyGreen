  import 'package:flutter/material.dart';
  

  class MyTextFormField extends StatefulWidget {
    IconData icon;
    final String hintText;
    //입력이 아무것도 없을때
    final String warningMessage1;

    //정규표현식이 틀렸을때
    final String warningMessage2;
    
    final Function(String formValue) validValue;
    String formValue;

    MyTextFormField({Key? key, 
    required this.icon,
    required this.hintText,
    required this.warningMessage1,
    required this.warningMessage2,
    required this.validValue,
    required this.formValue
    }) : super(key: key);

    _MyTextFormField createState() => _MyTextFormField();

  }

    class _MyTextFormField extends State<MyTextFormField>{
    
    @override
    Widget build(BuildContext context){
      return TextFormField(
                      maxLength: 20,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      
                      obscureText: true,
                      
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        //add prefix icon
                      prefixIcon: Icon(
                        widget.icon,
                        color: Colors.black),

                      hintText: widget.hintText,
                        //default border
                        enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(0.0)),

                        //focus border
                        focusedBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide: const BorderSide(
                                width: 3, color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(0.0)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return widget.warningMessage1;
                        } else if (!widget.validValue(widget.formValue)) {
                          return widget.warningMessage2;
                        }
                        return null;
                      },
                      onSaved: (value) => widget.formValue = value!

                    );}}