// 달력 이벤트 예시 파일입니다.

import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  //식물 이름
  final String plant_name;

  //이벤트 제목
  final String title;

  //이벤트 날짜
  // final DateTime date;

  //감정(1~5 로 해서 숫자에 해당하는 그림 출력해주면 될듯.)
  final String emotion;

  //마커 색상
  final String color;

  //이벤트 내용
  final String content;

  const Event(
    this.plant_name,
    this.title,
    this.emotion,
    this.color,
    this.content,
  );

  String toName() {
    return plant_name;
  }

  @override
  String toString() => plant_name;
}

//Event('plant_name , title , date , emotion , images , content)
Map<DateTime, dynamic> eventSource = {
  DateTime(2023, 5, 12): [
    const Event(
      'Pot1',
      '오운완 ~!',
      '😀',
      '0022FF ',
      '렛풀다운을 재밌게 완료했다.',
    ),
  ],
  DateTime(2023, 5, 14): [
    const Event(
      'Pot1',
      '오운ss완 ~!',
      '😀',
      '0022FF ',
      '렛풀다운을 재밌게 완료했다.',
    ),
    const Event(
      'Pot2',
      '오운완1111 ~!',
      '😀',
      '0022FF ',
      '렛풀다운을 재밌게 완료했다.',
    ),
  ],
};

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap(
  equals: isSameDay,
)..addAll(eventSource);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

// 현재날짜
final kToday = DateTime.now();

//4월 5일 기준 1월 5일 ~ 7월 5일
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

// 해야할일
// 투데이에 저장되지않는 버그 수정
// item을 받게되면 0,1,2,3... 이런식으로 받는데 반복 안되게끔
