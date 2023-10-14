import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String prefName = "com.example.doctech";
  static String userToken = "${prefName}userToken";
  static String userId = "${prefName}userId";
  static String isLoggedin = "${prefName}isLoggedin";
  static String username = "${prefName}username";
  static String isLogin = "${prefName}isLogin";
  static String userAuth = "${prefName}userAuth";
  static String sessionToken = "${prefName}sessionToken";

  static Future<bool> isLogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedin) ?? false;
  }

  static Future<SharedPreferences> getPrefInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static Future<void> setLogIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedin, value);
  }

  static setUserauth(String userData) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(userAuth, userData);
  }

  static setSessionToken(String token) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(sessionToken, token);
  }

  static setChatData(List<Map<String, String>> avail, String name) async {
    SharedPreferences preferences = await getPrefInstance();
    String encodedMap = json.encode(avail);
    preferences.setString(name, encodedMap);
  }

  static Future<String> getSessionToken() async {
    SharedPreferences preferences = await getPrefInstance();
    var token = preferences.getString(sessionToken) ?? "";
    return token;
  }
}
