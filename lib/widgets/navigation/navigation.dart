import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  // StatefulWidget로 변경
  const Navigation({
    Key? key,
  }) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  // _selectedIndex를 상태 변수로 이동
  int selectedIndex = 0; // 현재 선택된 인덱스를 저장하는 변수

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type:
          BottomNavigationBarType.fixed, // Use one of the types mentioned above

      // 클릭 이벤트
      onTap: (int index) {
        setState(() {
          print('index test : ${index}');
          selectedIndex = index; // 선택된 인덱스 변경
        });

        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            Navigator.pushNamed(context, '/calendar');
            break;
          case 2:
            Navigator.pushNamed(context, '/board');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
          default:
        }
      },

      backgroundColor: Colors.blue,

      //selected된 item color
      selectedItemColor: Colors.black54,
      showUnselectedLabels: true,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: '홈',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: '달력'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add_sharp), label: '게시판'),
        BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded), label: '프로필'),
      ],
    );
  }
}
