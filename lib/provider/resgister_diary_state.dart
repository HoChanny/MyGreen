import 'package:get/get.dart';

class DiaryState extends GetxController {
  Map<String, dynamic> diaryData = {};

void setPublic(bool public) {
    diaryData['public'] =public;
    update();
  }

  // 날짜를 저장하는 메서드
  void setDate(DateTime date) {
    diaryData['date'] = date;
    update();
  }

  // 감정을 저장하는 메서드
  void setEmotion(String emotion) {
    diaryData['emotion'] = emotion;
    update();
  }

  void setImage(dynamic image) {
    diaryData['image'] = image;
    update();
  }

  // 내용을 저장하는 메서드
  void setContent(String content) {
    diaryData['content'] = content;
    update();
  }

  // 내용을 저장하는 메서드
  void setTitle(String title) {
    diaryData['title'] = title;
    update();
  }

  // 날짜, 감정, 내용을 함께 저장하는 메서드
  void setDiaryEntry(String date, String emotion, String content) {
    diaryData['date'] = date;
    diaryData['emotion'] = emotion;
    diaryData['content'] = content;
    update();
  }

  // 필요한 경우 날짜, 감정, 내용을 함께 가져오는 메서드
  Map<String, dynamic> getDiaryEntry() {
    return {
      'date': diaryData['date'],
      'emotion': diaryData['emotion'],
      'image': diaryData['image'],
      'content': diaryData['content'],
      'title': diaryData['title'],
    };
  }
}
