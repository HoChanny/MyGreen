import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  
  State<CalendarPage> createState() => _CalendarPageState();
  
}

class _CalendarPageState extends State<CalendarPage> {
    DateTime selectedDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
  );  

  DateTime focusedDay = DateTime.now();

   Map<DateTime, List<Event>> events = {
    DateTime.utc(2023,3,13) : [ Event('title'), Event('title2') ],
    DateTime.utc(2022,7,14) : [ Event('title3') ],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      appBar: AppBar(
        //왼쪽에 배치하기
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            // ignore: avoid_print
            print('back button is clicked');
            Navigator.pop(context);
          },
        ),

        title: const Text('Calander'),
        //Title Center로 설정
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: TableCalendar(
            locale: 'ko_KR', // 추가

            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: focusedDay, 
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          // 선택된 날짜의 상태를 갱신합니다.	
          setState((){
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
            calendarStyle: CalendarStyle(markerSize: 10.0,
          markerDecoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle
          ),),
                  eventLoader: _getEventsForDay),
      ),
    );
  }
}
class Event {
  String title;

  Event(this.title);
}