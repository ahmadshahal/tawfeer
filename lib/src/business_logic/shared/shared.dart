import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawfeer/src/business_logic/models/user.dart';

class Shared {
  static User? myUser;
  static String? token;
  static late SharedPreferences pref;
  static GlobalKey<RefreshIndicatorState>? homeRefreshIndicatorKey;
  static GlobalKey<RefreshIndicatorState>? myProductsRefreshIndicatorKey;
  static String baseURL = 'https://tawfeerapp.000webhostapp.com';
  // 'http://192.168.1.105:8000'
}