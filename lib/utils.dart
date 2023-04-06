// 달력 이벤트 예시 파일입니다.

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  //이벤트 제목
  final String title;

  //이벤트 내용
  final String content;
  const Event(this.title, this.content);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

Map<String, Map<String, dynamic>> e = {
  'start': {},
  '1': {
    'title': 'first',
    'content': 'first events',
    'year': 2023,
    'month': 4,
    'day': 6,
  },
  '2': {
    'title': 'second',
    'content': 'second events',
    'year': 2023,
    'month': 4,
    'day': 15,
  },
  '3': {
    'title': '3',
    'content': '3',
    'year': 2023,
    'month': 4,
    'day': 13,
  },
  '4': {
    'title': '4',
    'content': '4',
    'year': 2023,
    'month': 4,
    'day': 17,
  },
  '5': {
    'title': '5',
    'content': '5 events',
    'year': 2023,
    'month': 4,
    'day': 25,
  },
  '6': {
    'title': '5',
    'content': '555 events',
    'year': 2023,
    'month': 4,
    'day': 25,
  },
  'end': {}
};
const int list =1;
// ignore: prefer_for_elements_to_map_fromiterable
final _kEventSource = Map.fromIterable(

    //generate [0,1,2,3,4]
    List.generate(e.length, (index) => index),
    //item [0,1,2,3,4]
    key: (item) => DateTime.utc(
          e[item.toString()]?['year'] ?? 1,
          e[item.toString()]?['month'] ?? 1,
          e[item.toString()]?['day'] ?? 1,
        ),
    value: (item) => List.generate(
        list,
        (index) => Event('${e[item.toString()]?['title']}',
            '${e[item.toString()]?['content']}')))
  ..addAll({
    kToday: [],
  });

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