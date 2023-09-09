import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:mygreen/screen/calendar.dart';
import 'package:mygreen/screen/home.dart';

void main() async {
  await initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '',
      home: MyAppPage(),
    );
  }
}

// 기본 홈
class MyAppPage extends StatefulWidget {
  const MyAppPage({super.key});

  @override
  State<MyAppPage> createState() => MyAppState();
}

class MyAppState extends State<MyAppPage> {
  // 바텀 네비게이션 바 인덱스
  int _selectedIndex = 0;

  final List<Widget> _navIndex = [
    const HomeScreen(),
    const CalendarPage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navIndex.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '달력',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}