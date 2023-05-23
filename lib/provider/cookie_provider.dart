import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginCookie extends GetxController{
  String cookie = "";
  Map<String, Map<String,String>>profile = {
  "pot1": {
    "plant_name": "Pot 1",
    "temperature": "25°C",
    "wateringCycle": "2 days",
    "color": "#FF0000"
  },
  "pot2": {
    "plant_name": "Pot 2",
    "temperature": "22°C",
    "wateringCycle": "3 days",
    "color": "#00FF00"
  }
};

  void setCookie(String newCookie){
    cookie = newCookie;
    update();
  }

  void setProfile(newProfile){
    profile = newProfile;
    update();
  }
}