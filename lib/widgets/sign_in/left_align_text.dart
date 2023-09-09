import 'package:flutter/material.dart';

class LeftAlignText extends StatelessWidget {
  final String content;

  LeftAlignText(
    {
      Key? key,
      required this.content,
    }
  ):super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalSize = MediaQuery.of(context).size.width;
    return Align(
                alignment: Alignment.centerLeft, // 왼쪽 정렬
                child: Text(
                  content,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: horizontalSize * 0.06,
                  ),
                ),
              );
  }
}