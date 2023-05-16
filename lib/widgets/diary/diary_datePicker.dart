// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({Key? key}) : super(key: key);

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  String _selectedDate = '';

  @override
  Widget build(BuildContext context) {
    return 
      
      Container(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                _selectedDate,
                style: TextStyle(fontSize: 24),
              ),
              IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () => _selectDate(context),
              )
            ],
          ),
        ),
      
    );
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selected != null) {
      setState(() {
        _selectedDate = (DateFormat.yMMMd()).format(selected);
      });
    }
  }
}
