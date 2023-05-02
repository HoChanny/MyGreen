import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginCookie extends GetxController{
  String cookie = "";

  void setCookie(String newCookie){
    cookie = newCookie;
    update();
  }
}