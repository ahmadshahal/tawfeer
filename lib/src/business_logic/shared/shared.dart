import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawfeer/src/business_logic/models/user.dart';

class Shared {
  static User? myUser;
  static String? token;
  static late SharedPreferences pref;
}