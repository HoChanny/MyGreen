import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalState extends GetxController {
  String cookie = "";
  String deviceToken = "";
  Map<String, Map<String, String>> profile = {};
  Color potColor = Colors.lightGreen;

  void setPotColor(newColor){
    potColor = newColor;
    update();
  }

  void setCookie(String newCookie) {
    cookie = newCookie;
    update();
  }

  void setProfile(newProfile) {
    profile = newProfile;
    update();
  }

  void setDeviceToken(String newToken){
    deviceToken = newToken;
    update();
  }
}
