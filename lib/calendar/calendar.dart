import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mygreen/calendar/widgets/AddButton.dart';
import 'package:mygreen/calendar/widgets/SearchButton.dart';

import 'package:mygreen/calendar/widgets/MyCalendar.dart';

import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //왼쪽에 배치하기
        leading: const BackButton(),
        //Title Center로 설정
        title: const Text('Calander'),

        actions: [AddButton(), SearchButton()],
        centerTitle: true,
      ),
      body: Container(padding: const EdgeInsets.all(16), child: MyCalendar()),
    );
  }
}
