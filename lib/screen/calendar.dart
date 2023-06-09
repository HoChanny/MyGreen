import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mygreen/widgets/calendar/calendar_add_button.dart';
import 'package:mygreen/widgets/calendar/calendar_search_button.dart';

import 'package:mygreen/widgets/calendar/calendar_my_calendar.dart';
import 'package:mygreen/utils.dart';

class CalendarPage extends StatefulWidget {
  final String id;
  final String plant_name;
  final Color color;

  const CalendarPage(
      {required this.id,required this.plant_name, required this.color, super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Title Center로 설정
        title: Text(' Calendar'),
        actions: [AddButton(id : widget.id , plant_name: widget.plant_name,), ],
        centerTitle: true,
        backgroundColor: widget.color,
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
                  child: MyCalendar(id : widget.id,
                      plant_name: widget.plant_name, color: widget.color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
