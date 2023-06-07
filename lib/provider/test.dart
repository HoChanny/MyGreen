import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginCookie extends GetxController{
  Map profile = {};

  void setCookie(Map newProfile){
    profile = newProfile;
    update();
  }
}