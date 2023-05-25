import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:mygreen/screen/calendar.dart';
import 'package:mygreen/screen/diary.dart';

import 'package:mygreen/utils.dart';

class ViewMyPotPage extends StatefulWidget {
  final String name;
  final Color color;
  final MemoryImage image;
  final String temperature;
  final String wateringCycle;

  const ViewMyPotPage(
      {required this.name,
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
    print(eventSource[0]);
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
                      border: Border.all(width: 10, color: widget.color)),
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
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalendarPage(),
                  ),
                );
              },
              child: Text("일기 작성")),
          Expanded(
            child: ListView.builder(
              itemCount: eventSource.length,
              itemBuilder: (BuildContext context, int index) {
                DateTime date = eventSource.keys.elementAt(index);
                List<Event> events = eventSource[date];
                int length = events.length;

                for (int i = 0; i < length; i++) {
                  if (events[i].plant_name == widget.name) {
                    print(events[i].title);
                    print(events[i].plant_name);

                    return Column(
                      children: [
                        Text(
                          (DateFormat.yMMMd()).format(date),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            // 클릭시 이벤트 발생
                            // 제목
                            title: Text(events[i].title),
                            // 내용
                            subtitle: Text(events[i].content),
                          ),
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
