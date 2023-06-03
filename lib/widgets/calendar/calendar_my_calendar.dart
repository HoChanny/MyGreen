// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

//  일기 목록
import '../../utils.dart';
//  일기 상세 페이지
import 'package:mygreen/screen/diary.dart';

class MyCalendar extends StatefulWidget {
  final Color color;
  const MyCalendar({required this.color, super.key});
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  get http => null;

  @override
  void initState() {
    super.initState();
    // updateEvent();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  void updateEvent() async {
    dynamic hashMap = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(await fetchDataFromServer());
    setState(() {
      eventSource = hashMap;
      _selectedEvents = ValueNotifier(
          _getEventsForDay(_selectedDay!)); //api 통신 이후에 선택된 작업 리스트 다시 그려줌
    });
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

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

  List<Map<DateTime, dynamic>> fetchEventSource = [];
  //날짜들 받아오기
  List<DateTime> eventSourceDate = [];
  //내용 받아오기
  List<String> eventSourceContent = [];

  Future<Map<DateTime, dynamic>> fetchDataFromServer() async {
    try {
      final url = Uri.parse('https://iotvase.azurewebsites.net/green');
      var profileController;
      final response =
          await http.get(url, headers: {'Cookie': profileController.cookie});

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          // eventSource = jsonData.map((data) => data as Map<DateTime,dynamic>).toList());
          // eventSourceDate =
          //     jsonData.map((data) => data as DateTime.toList();
          // eventSourceContent =
          //   jsonData.map((data) => data as String.toList();
          fetchEventSource =
              jsonData.map((data) => data as Map<DateTime, dynamic>).toList();

          int len = eventSourceDate.length;

          for (int i = 0; i < len; i++) {
            // 이벤트를 추가할 날짜
            DateTime eventDate = DateTime(eventSourceDate[i].year,
                eventSourceDate[i].month, eventSourceDate[i].day);

            // eventDate 키가 이미 존재하는지 확인
            if (eventSource.containsKey(eventDate)) {
              // 이미 해당 날짜에 이벤트가 있는 경우, 기존 이벤트 목록에 새로운 이벤트를 추가
              eventSource[eventDate].add(eventSourceContent);
            } else {
              // 해당 날짜에 이벤트가 없는 경우, 새로운 이벤트 목록을 생성하여 추가
              eventSource[eventDate] = [eventSourceContent];
            }
          }
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
    return eventSource;
  }

  @override
  Widget build(BuildContext context) {
    print(eventSource);

    //마커추가하는로직
    print(kEvents..addAll(eventSource));
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            // marker 색 변경
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isEmpty) return SizedBox();
                return Row(
                  children: [
                    SizedBox(
                      height: 10,
                      width: 50, // set the width to the screen width
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection:
                            Axis.horizontal, // set the direction to horizontal
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                            width: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                                color: widget.color,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },

              //현재 선택 날짜
              selectedBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            locale: 'ko-KR',
            headerStyle: HeaderStyle(
              titleTextFormatter: (date, locale) =>
                  DateFormat.yMMMM(locale).format(date),
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'NanumSquareOTF',
                fontWeight: FontWeight.w700,
              ),
            ),
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: true,
            ),
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        //클릭시 이벤트 발생
                        onTap: () {
                          //diary 페이지에 넘기는 데이터 값들
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiaryPage(
                                      plant_name: value[index].plant_name,
                                      title: value[index].title,
                                      date: returnDate(value, index),
                                      emotion: value[index].emotion,
                                      color: widget.color,
                                      content: value[index].content,
                                      image: value[index].image,
                                    )),
                          );
                        },
                        //제목
                        title: Text('${value[index].title}'),
                        //내용
                        subtitle: Text('${value[index].content}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
