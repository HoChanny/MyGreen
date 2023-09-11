import 'package:get/get.dart';

class DiaryController extends GetxController {
  int count = 0;
  void increment() {
    count++;
    update();
  }
}
