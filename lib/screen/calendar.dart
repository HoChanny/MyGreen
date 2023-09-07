import 'package:flutter/material.dart';
import 'package:mygreen/widgets/calendar/calendar_add_button.dart';
import 'package:mygreen/widgets/calendar/calendar_search_button.dart';
import 'package:mygreen/widgets/calendar/calendar_my_calendar.dart';

import 'diary.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'), // 'Calander'를 'Calendar'로 수정
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
                      0, 0, 0, 0), // 여기에 원하는 마진 값 설정
                  child: MyCalendar(),
                ),
              ),
ElevatedButton(
  child: Text('Diary'),
  onPressed: () {
    // Navigate to the DiaryPage when the button is pressed
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DiaryPage(plant_name: 'plant_name',title: 'title',date:'2023-08-18',emotion: 1,color: 'ffffffff936a1cd8',content: 'contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent',)), // Replace 'DiaryPage' with your actual diary page widget
    );
  },
)
,
            ],
          ),
        ),
      ),
    );
  }
}
