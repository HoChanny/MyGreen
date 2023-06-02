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

  //이벤트 내용
  final String content;

  //이벤트 사진
  final String image;

  const Event(
    this.plant_name,
    this.title,
    this.emotion,
    this.content,
    this.image,
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
    const Event('Pot1', '오운완 ~!', '4', '렛풀다운을 재밌게 완료했다.', 'a'),
  ],
  DateTime(2023, 5, 11): [
    const Event('Pot1', '오운완 ~!', '4', '렛풀다운을 재밌게 완료했다.', 'a'),
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
