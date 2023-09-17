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
import 'package:mygreen/screen/register_diary/set_public.dart';
import 'package:mygreen/screen/web/diary.dart';

import 'package:mygreen/utils.dart';
import 'package:mygreen/widgets/sign_in/left_align_text.dart';
import 'package:table_calendar/table_calendar.dart';

import '../provider/global_state.dart';

class ViewMyPotPage extends StatefulWidget {
  final String name;
  final Color color;
  final MemoryImage image;
  final String status;

  const ViewMyPotPage(
      {required this.name,
      required this.color,
      required this.image,
      required this.status,
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
    List<String> eventSourceId = [];

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
        print(jsonData);
        eventSource = {};

        setState(() {
          eventSourceId =
              jsonData.map((data) => data['_id'] as String).toList();
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
          (eventSourceId.join(','));

          int len = eventSourceDate.length;

          for (int i = 0; i < len; i++) {
            Event newEvent = Event(
                eventSourceId[i],
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

  String formatDate(String dateStr) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('yyyy.MM.dd');
    final date = inputFormat.parse(dateStr);
    return outputFormat.format(date);
  }

  Widget build(BuildContext context) {
    //일기 날짜 최신순으로 정렬
    Map<DateTime, dynamic> sortedEventSource = Map.fromEntries(
        eventSource.entries.toList()..sort((b, a) => a.key.compareTo(b.key)));
    
    profileController.setPotColor(widget.color);

    var horizontalSize = MediaQuery.of(context).size.width;
    var verticalSize = MediaQuery.of(context).size.height;

    print(eventSource.keys);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: widget.color,
      ),
      body: Stack(children: [ 
      
      Column(
        children: [
          Container(
              padding: EdgeInsets.all(horizontalSize * 0.09),
              child: Stack(
                children: [
                  Container(
                    width: verticalSize * 0.25,
                    height: verticalSize * 0.25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 8, color: widget.color)),
                    child: CircleAvatar(
                      backgroundImage: widget.image,
                      radius: 50,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: verticalSize * 0.08,
                      height: verticalSize * 0.08,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                AssetImage('assets/image/${widget.status}.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  )
                ],
              )),
          // ElevatedButton(onPressed: () {}, child: Text("프로필 수정")),
          LeftAlignText(content: '  내가 쓴 일기'),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            width: horizontalSize,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.black)
              )
            )),
         
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
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          child: Container(
                            height: verticalSize * 0.2,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1.0, color: Colors.black),
                              )
                            ),
                            child: ListTile(
                              onTap: () {
                                //diary 페이지에 넘기는 데이터 값들
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DiaryPage(id: events[i].id),
                                  ),
                                );
                              },
                              leading: Image.memory(
                                base64Decode(events[i].image),
                                width: horizontalSize * 0.2, // 이미지의 가로 크기 설정
                                height: verticalSize * 0.5, // 이미지의 세로 크기 설정
                              ),
                              // 제목
                              title: Text(
                                events[i].title,
                                style: TextStyle(
                                  fontSize: 24, // 폰트 크기 설정 (원하는 크기로 변경)
                                  fontWeight:
                                      FontWeight.bold, // 글꼴 굵기 설정 (선택 사항)
                                  // 다른 스타일 속성도 추가할 수 있습니다.
                                ),
                              ),
                              // 내용
                              subtitle: Text(
                                '${events[i].content} \n${formatDate(date.toString())}',
                                style: TextStyle(
                                  fontSize: 18, // 폰트 크기 설정 (원하는 크기로 변경)
                                  fontWeight:
                                      FontWeight.bold, // 글꼴 굵기 설정 (선택 사항)
                                  // 다른 스타일 속성도 추가할 수 있습니다.
                                ),
                              ),
                            ),
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
      Positioned(
        right: 0,
        bottom: 0,
        child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SetPublicScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                minimumSize: Size(verticalSize*0.08, verticalSize*0.08),),
              child: Icon(Icons.edit, size: verticalSize*0.06,)),)
      ])
    );
  }
}
