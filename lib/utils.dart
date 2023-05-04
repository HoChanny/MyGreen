// 달력 이벤트 예시 파일입니다.

import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  //이벤트 제목
  final String title;

  //이벤트 내용
  final String content;

  //마커 색상
  final String color;

  const Event(this.title, this.content,this.color);

  String toColor(){
    return color;
  }
  @override
  String toString() => color;


  
}

Map<DateTime, dynamic> eventSource = {
  DateTime(2023, 4, 18): [
    const Event('기분좋음', '맛있는 음식을 먹었다.','FF00FF'),
    const Event('자기 셀카 올리기', '식물이랑 같이 찍은 내 사진','000000')
  ],
  DateTime(2023, 4, 20): [Event('5분 기도하기', '내일 시험 잘보게 해주세요','FF22FF')],
  DateTime(2023, 4, 21): [
    Event('5분 명상하기', '시험 화이팅','FF00FF'),
    Event('가족과 저녁식사 하기', '맛있었다.','FF00FF'),

  ]
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