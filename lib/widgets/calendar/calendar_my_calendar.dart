// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

//  일기 목록
import '../../provider/global_state.dart';
import '../../utils.dart';
//  일기 상세 페이지

class MyCalendar extends StatefulWidget {
  final String plant_name;
  final Color color;
  const MyCalendar({required this.plant_name, required this.color, super.key});
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

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('e : $eventSource}');
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            // marker 색 변경
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                print(events);
                if (events.isEmpty) return const SizedBox();

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
                          print(events[index].toString() == widget.plant_name);
                          if (events[index].toString() == widget.plant_name) {
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
                          } else {
                            return const SizedBox();
                          }
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
              builder: (context, value, events) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    print('value = ${value.toString()}');
                    if (value[index].toString() == widget.plant_name) {
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => DiaryPage(
                            //             plant_name: value[index].plant_name,
                            //             title: value[index].title,
                            //             date: returnDate(value, index),
                            //             emotion: value[index].emotion,
                            //             color: widget.color,
                            //             content: value[index].content,
                            //             image: MemoryImage(
                            //                 base64Decode(value[index].image)),
                            //           )),
                            // );
                          },
                          //제목
                          title: Text('${value[index].title}'),
                          //내용
                          subtitle: Text('${value[index].content}'),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
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
