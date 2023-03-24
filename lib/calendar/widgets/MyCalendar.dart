import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatefulWidget {
  _MyCalendar createState() => _MyCalendar();
}

class _MyCalendar extends State<MyCalendar> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  Map<DateTime, List<Event>> events = {
    //디비에서 가져온 데이터 입력해주기!
    DateTime.utc(2023, 3, 13): [Event('title', '밥'), Event('title2', 'ㅁ')],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        locale: 'ko_KR', // 추가

        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: focusedDay,
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          // 선택된 날짜의 상태를 갱신합니다.
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
          });
        },
        selectedDayPredicate: (DateTime day) {
          // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
          return isSameDay(selectedDay, day);
        },
        //헤더스타일
        headerStyle: HeaderStyle(
          titleCentered: true,
          titleTextFormatter: (date, locale) =>
              DateFormat.yMMMMd(locale).format(date),
          formatButtonVisible: false,
          titleTextStyle: const TextStyle(
            fontSize: 20.0,
            color: Colors.blue,
          ),
        ),
        calendarStyle: const CalendarStyle(
          markerSize: 10.0,
          markerDecoration:
              BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        ),
        eventLoader: _getEventsForDay);
  }
}

class Event {
  String title;
  String content;
  Event(this.title, this.content);
}
