import 'package:flutter/material.dart';
import 'dart:convert';

class ViewMyPotPage extends StatefulWidget {
  final String name;
  final Color color;
  final MemoryImage image;
  final String temperature;
  final String wateringCycle;

  const ViewMyPotPage({
    required this.name,
    required this.color,
    required this.image,
    required this.temperature,
    required this.wateringCycle,
     super.key});

  @override
  State<ViewMyPotPage> createState() => _ViewMyPotPageState();
}

class _ViewMyPotPageState extends State<ViewMyPotPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: widget.color,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(size * 0.09),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 10, color: widget.color)),
                  child: CircleAvatar(
                    backgroundImage: widget.image,
                    radius: 50,
                  ),
                ),
                SizedBox(
                  width: size * 0.1,
                ),
                Column(
                  children: [
                    Text("현재상태"),
                    Text("선호 온도: " + widget.temperature),
                    Text("물 주는 주기: " + widget.wateringCycle),
                  ],
                )
              ],
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text("프로필 수정")),
        ],
      ),
    );
  }
}
