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

    //최신 일기 출력해주기
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

    // 새로운 이벤트 생성
    Event newEvent = const Event(
      'Pot3',
      '새로운 이벤트입니다.',
      '🎉',
      'FF0000',
      '새로운 이벤트를 추가했습니다.',
    );

    // 이벤트를 추가할 날짜
    DateTime eventDate = DateTime(2023, 5, 16);

    // eventDate 키가 이미 존재하는지 확인
    if (eventSource.containsKey(eventDate)) {
      // 이미 해당 날짜에 이벤트가 있는 경우, 기존 이벤트 목록에 새로운 이벤트를 추가
      eventSource[eventDate].add(newEvent);
    } else {
      // 해당 날짜에 이벤트가 없는 경우, 새로운 이벤트 목록을 생성하여 추가
      eventSource[eventDate] = [newEvent];
    }
    //이벤트 추가 -> 정렬 -> 출력하기 로직

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
            ),
          ),
        ],
      ),
    );
  }
}
