import 'package:flutter/material.dart';
import 'package:mygreen/calendar/widgets/add_button.dart';
import 'package:mygreen/calendar/widgets/search_button.dart';

import 'package:mygreen/calendar/widgets/my_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<String> fruits = ['appaaale', 'banana', 'orange'];

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
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(   
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0), // Set margin for all sides
                  child: MyCalendar(),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0), // Set margin for all sides
                  child: ListV(lst : fruits),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
