import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:mygreen/login/login.dart';

class MyElevatedSubmitButton extends StatefulWidget {

  final String Text;

  MyElevatedSubmitButton({Key? key, 
    required this.Text,
   }) : super(key: key);

  _MyElevatedSubmitButton createState() => _MyElevatedSubmitButton();


}

  class _MyElevatedSubmitButton extends State<MyElevatedSubmitButton>{
    @override
    Widget build(BuildContext context){

      return ElevatedButton(
                    onPressed: (){
                      
                    },
                     
                     style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.lightGreen),

                    ),
                     child: Text(widget.Text,
                     style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                  );
  }
  }