import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {

  final String warningMessage;
  final String hintText;
  IconData icon;
  String formValue;
  bool obscureText;
  MyTextFormField({Key? key, 
   required this.icon,
   required this.hintText,
   required this.warningMessage,
   required this.obscureText,
   required this.formValue}) : super(key: key);

  _MyTextFormField createState() => _MyTextFormField();

}

  class _MyTextFormField extends State<MyTextFormField>{
  @override
  Widget build(BuildContext context){
    return TextFormField(
                  maxLength: 20,
                  obscureText: widget.obscureText,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    //add prefix icon
                    prefixIcon: Icon(widget.icon,color: Colors.black),

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
                      return widget.warningMessage;
                    } return null;
                  },
                  
                  onSaved: (value) => widget.formValue = value!
                  ,
                );
      }
}

