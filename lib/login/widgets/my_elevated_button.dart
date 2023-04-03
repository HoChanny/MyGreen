// ignore: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyElevatedButton extends StatefulWidget {
  final String id;
  final String password;
  final Function() valid;
  final Future<Response> Function(String id, String password) post;

  MyElevatedButton({
    Key? key,
    required this.id,
    required this.password,
    required this.valid,
    required this.post,
  }) : super(key: key);

  _MyElevatedButton createState() => _MyElevatedButton();
}

class _MyElevatedButton extends State<MyElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.valid();
        widget.post(widget.id, widget.password);
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size(1000, 50),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
      child: const Text(
        '로그인 하기',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
