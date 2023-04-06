import 'package:flutter/material.dart';
import 'package:mygreen/widgets/calendar/calendar_add_button.dart';
import 'package:mygreen/widgets/calendar/calendar_search_button.dart';

import 'package:mygreen/widgets/calendar/calendar_my_calendar.dart';
import 'package:mygreen/utils.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  @override
  
  Widget build(BuildContext context) {
    print(' kEvents : $kEvents \n');
    return Scaffold(
      appBar: AppBar(
        //왼쪽에 배치하기
        leading: const BackButton(),
        //Title Center로 설정
        title: const Text('Calander'),

        actions: [AddButton(), SearchButton()],
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(
                      0, 0, 0, 0), // Set margin for all sides
                  child: MyCalendar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
