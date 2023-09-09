import 'package:flutter/material.dart';
import 'package:mygreen/screen/calendar.dart';
import 'package:mygreen/screen/login_page.dart';
import 'package:mygreen/screen/select_pot_screen.dart';
import 'package:mygreen/screen/sign_up/set_email_screen.dart';
import 'package:mygreen/screen/sign_up/set_id_screen.dart';
import 'package:mygreen/screen/sign_up/set_password_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _navIndex = [
    SelectPotScreen(),
    SetIdScreen(),
    SetPasswordScreen(),
    SetEmailScreen(),
  ];

  final List appBarTitle = ['내 화분', '내 일기', '게시판', '내 정보'];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: SizedBox(
            width: 500,
          ), // 옆으로 밀어야 중간으로 가네요..
          title: Center(
              child: Text(
            appBarTitle[_selectedIndex],
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Text(
                  '로그아웃',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: _navIndex.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.blue,
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_florist),
              label: '내 화분',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: '내 일기',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum),
              label: '게시판',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '내 정보',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onNavTapped,
        ));
  }
}
