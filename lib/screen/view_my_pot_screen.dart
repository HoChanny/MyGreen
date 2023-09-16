import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:mygreen/screen/calendar.dart';
import 'package:mygreen/screen/register_diary/set_date.dart';
import 'package:mygreen/screen/web/diary.dart';

import 'package:mygreen/utils.dart';
import 'package:table_calendar/table_calendar.dart';

import '../provider/global_state.dart';

class ViewMyPotPage extends StatefulWidget {
  final String name;
  final Color color;
  final MemoryImage image;

  const ViewMyPotPage(
      {required this.name,
      required this.color,
      required this.image,
      super.key});

  @override
  State<ViewMyPotPage> createState() => _ViewMyPotPageState();
}

class _ViewMyPotPageState extends State<ViewMyPotPage> {
  final profileController = Get.put(GlobalState());

  dynamic returnDate(value, index) {
    for (DateTime key in eventSource.keys) {
      for (Event event in eventSource[key]) {
        if (event == value[index]) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(key);
          print(formattedDate);
          return formattedDate;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDiaryDataFromServer('qrcode');
  }

  //날짜들 받아오기
  List<String> eventSourceDate = [];
  //내용 받아오기
  List<String> eventSourcePlantName = [];
  List<String> eventSourceTitle = [];
  List<String> eventSourceEmotion = [];
  List<String> eventSourceContent = [];
  List<String> eventSourceImage = [];

  //주기적으로 호출

  Future<void> fetchDiaryDataFromServer(String id) async {
    try {
      final url =
          Uri.parse('https://iotvase.azurewebsites.net/green/diary/$id');
      final response =
          await http.get(url, headers: {'Cookie': profileController.cookie});

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        eventSource = {};

        setState(() {
          eventSourceDate =
              jsonData.map((data) => data['date'] as String).toList();
          eventSourcePlantName =
              jsonData.map((data) => data['plant_name'] as String).toList();
          eventSourceTitle =
              jsonData.map((data) => data['title'] as String).toList();

          eventSourceEmotion =
              jsonData.map((data) => data['emotion'] as String).toList();
          eventSourceContent =
              jsonData.map((data) => data['content'] as String).toList();
          eventSourceImage =
              jsonData.map((data) => data['image'] as String).toList();

          (eventSourcePlantName.join(','));
          (eventSourceTitle.join(','));
          (eventSourceEmotion.join(','));
          (eventSourceContent.join(','));
          int len = eventSourceDate.length;

          for (int i = 0; i < len; i++) {
            Event newEvent = Event(
                eventSourcePlantName[i],
                eventSourceTitle[i],
                eventSourceEmotion[i],
                eventSourceContent[i],
                eventSourceImage[i]);

            DateTime fetchDate = DateTime.parse(eventSourceDate[i]);
            // 이벤트를 추가할 날짜
            // eventDate 키가 이미 존재하는지 확인
            if (eventSource.containsKey(fetchDate)) {
              // 이미 해당 날짜에 이벤트가 있는 경우, 기존 이벤트 목록에 새로운 이벤트를 추가
              eventSource[fetchDate].add(newEvent);
            } else {
              // 해당 날짜에 이벤트가 없는 경우, 새로운 이벤트 목록을 생성하여 추가
              eventSource[fetchDate] = [newEvent];
            }
            kEvents.addAll(eventSource);
          }
          print('success');

          print(eventSource);
        });
      } else {
        print('Failed to fetch data. Error code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error while fetching data: $error');
    }
    if (mounted) {
      setState(() {});
    }
  }

  void refreshData() {
    fetchDiaryDataFromServer('qrcode');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget decodeBase64Image(String base64String) {
    Uint8List bytes = base64Decode(base64String);
    return CircleAvatar(
      backgroundImage: MemoryImage(bytes),
      radius: 50,
    );
  }

  Widget build(BuildContext context) {
    //일기 날짜 최신순으로 정렬
    Map<DateTime, dynamic> sortedEventSource = Map.fromEntries(
        eventSource.entries.toList()..sort((b, a) => a.key.compareTo(b.key)));

    final size = MediaQuery.of(context).size.width;

    print(eventSource.keys);
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
                    builder: (context) => SetDateScreen(),
                  ),
                );
              },
              child: Text("일기 작성")),
          Expanded(
            child: ListView.builder(
              itemCount: sortedEventSource.length,
              itemBuilder: (context, i) {
                DateTime date = sortedEventSource.keys.elementAt(i);
                List<Event> events = sortedEventSource[date];
                int length = events.length;

                for (int i = 0; i < length; i++) {
                  if (true) {
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
                            onTap: () {
                              //diary 페이지에 넘기는 데이터 값들
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DiaryPage(
                                    plant_name: events[i].plant_name,
                                    title: events[i].title,
                                    date: returnDate(events, i),
                                    emotion: events[i].emotion,
                                    color: widget.color,
                                    content: events[i].content,
                                    image: MemoryImage(
                                        base64Decode(events[i].image)),
                                  ),
                                ),
                              );
                            }, // 클릭시 이벤트 발생
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
                return const SizedBox(
                  height: 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
