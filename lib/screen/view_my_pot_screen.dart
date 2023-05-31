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
  dynamic returnDate(value) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(value);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    //일기 날짜 최신순으로 정렬
    Map<DateTime, dynamic> sortedEventSource = Map.fromEntries(
        eventSource.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));

    String plant_name = '';
    String title = '';
    DateTime dates = DateTime.now();
    String emotion = '';
    String color = '';
    String content = '';

    int itemCount = sortedEventSource.length;

    for (int i = 0; i < itemCount; i++) {
      DateTime date = sortedEventSource.keys.elementAt(i);
      List<Event> events = sortedEventSource[date];
      print(events);
      int length = events.length;
      for (int i = 0; i < length; i++) {
        if (events[i].plant_name == widget.name) {
          plant_name = events[i].plant_name;
          title = events[i].title;
          dates = date;
          emotion = events[i].emotion;
          color = events[i].color;
          content = events[i].content;
          break;
        }
      }
    }

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
            child: Container(
              child: Column(
                children: [
                  if (true)
                    Column(
                      children: [
                        Text(
                          (DateFormat.yMMMd()).format(dates),
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
                            onTap: () {
                              // Diary 페이지에 넘기는 데이터 값들
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DiaryPage(
                                    plant_name: plant_name,
                                    title: title,
                                    date: returnDate(dates),
                                    emotion: emotion,
                                    color: color,
                                    content: content,
                                  ),
                                ),
                              );
                            }, // 클릭 시 이벤트 발생
                            // 제목
                            title: Text(title),
                            // 내용
                            subtitle: Text(content),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ), // child: ListView.builder(
            //   itemCount: sortedEventSource.length,
            //   itemBuilder: (context, i) {
            //     DateTime date = sortedEventSource.keys.elementAt(i);
            //     List<Event> events = sortedEventSource[date];
            //     int length = events.length;
            //     print(events);
            //     bool itemReturned =
            //         false; // Flag to track if an item has been returned

            //     for (int i = 0; i < length; i++) {
            //       if (events[i].plant_name == widget.name) {
            //         itemReturned =
            //             true; // Set flag to true as an item will be returned
            //         return Column(
            //           children: [
            //             Text(
            //               (DateFormat.yMMMd()).format(date),
            //               style: const TextStyle(
            //                 fontSize: 16.0,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.symmetric(
            //                 horizontal: 12.0,
            //                 vertical: 4.0,
            //               ),
            //               decoration: BoxDecoration(
            //                 border: Border.all(),
            //                 borderRadius: BorderRadius.circular(12.0),
            //               ),
            //               child: ListTile(
            //                 onTap: () {
            //                   // Diary 페이지에 넘기는 데이터 값들
            //                   Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                       builder: (context) => DiaryPage(
            //                         plant_name: events[i].plant_name,
            //                         title: events[i].title,
            //                         date: returnDate(events, i),
            //                         emotion: events[i].emotion,
            //                         color: events[i].color,
            //                         content: events[i].content,
            //                       ),
            //                     ),
            //                   );
            //                 }, // 클릭 시 이벤트 발생
            //                 // 제목
            //                 title: Text(events[i].title),
            //                 // 내용
            //                 subtitle: Text(events[i].content),
            //               ),
            //             ),
            //           ],
            //         );
            //       }
            //     }

            //     if (!itemReturned) {
            //       return const SizedBox(height: 0);
            //     }
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}