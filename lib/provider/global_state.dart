import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalState extends GetxController {
  String cookie = "";
  Map<String, Map<String, String>> profile = {};
  Color potColor = Colors.lightGreen;

  void setCookie(String newCookie) {
    cookie = newCookie;
    update();
  }

  void setProfile(newProfile) {
    profile = newProfile;
    update();
  }

  void setPotColor(newColor){
    potColor = newColor;
    update();
  }
}
