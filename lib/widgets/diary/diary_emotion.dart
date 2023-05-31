import 'package:flutter/material.dart';

class DiaryEmotion extends StatefulWidget {
  final String emotion;

  DiaryEmotion({
    required this.emotion,
    Key? key,
  }) : super(key: key);

  State<DiaryEmotion> createState() => _DiaryEmotionState();
}

class _DiaryEmotionState extends State<DiaryEmotion> {
  String icon = '';
  @override
  Widget build(BuildContext context) {
    if (widget.emotion == 1) {
      icon = '😡';
    } else if (widget.emotion == 2) {
      icon = '😠';
    } else if (widget.emotion == 3) {
      icon = '😮';
    } else if (widget.emotion == 4) {
      icon = '😀';
    } else {
      icon = '😍';
    }

    return Text(
      '${icon}',
      style: const TextStyle(
        fontSize: 50,
      ),
    );
  }
}
