import 'dart:convert';
import 'package:beverage_project/src/utils/api_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../model/login.dart';

class LoginService {
  /// ใช้งานข้อมูล SharedPreferences
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// ฟังก์ชั่นดึงสถานะการล็อกอิน จากข้อมูล SharedPreferences
  static Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('loginSuccess') ?? false;
  }

  /// ฟังก์ชั่นดึงข้อมูลผู้ใช้ทั่วไป จากข้อมูล SharedPreferences
  static Future<User> getUser() async {
    final SharedPreferences prefs = await _prefs;
    return User(
      // id: prefs.getInt('user_id')!,
      email: prefs.getString('email')!,
      token: prefs.getString('token')!,
      name: prefs.getString('name')!,
      phone_number: prefs.getString('phone_number')!
    );
  }

  /// ฟังก์ชั่นดึงข้อมูลจาก server โดยใช้ token
  static Future<Map<String, dynamic>> get(String token) async {
    final SharedPreferences prefs = await _prefs;
    var result;

    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.get(
      Uri.parse(''),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      var body = response.body;
      result = await json.decode(body);
      result = result[0]; // เนื่องจากข้อมูลจาก api เป็น array เลยใช้เฉพาะข้อมูล key = 0
      //notifyListeners();
    } else { // กรณี error
      throw Exception('Failed to load data');
    }
    return result;
  }

  /// ฟังก์ชั่นดึงข้อมูล token จากข้อมูล SharedPreferences
  Future<String> getToken() async {
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString("token")!;
    return token;
  }

  /// ฟังก์ชั่นสำหรับทำการล็อกอิน โดยส่งค่าไปยัง server
  static Future<Map<String, dynamic>> authen(String? email, String? password) async {
    final SharedPreferences prefs = await _prefs;
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.post(
      Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndPoints.login),
      //Uri.parse('http://192.168.1.10:8000/api/auth/login'),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );

    print(loginData);
    print('Status code is ${response.statusCode}');

    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      var body = response.body;
      result = await json.decode(body);

      print(result);
      final token = result['access_token'];
      print('token is : ${token}');
      print('data load success');

        // บันทึกข้อมูลเบื้องต้นลงใน SharedPreferences
        //await prefs.setInt("user_id", int.parse(result['id']));
      await prefs.setString("email", result['user']['email']);
      await prefs.setString("name", result['user']['name']);
      await prefs.setString("phone_number", result['user']['phone_number']);
      await prefs.setString("token", result['access_token']);
      await prefs.setBool("loginSuccess", true);
        //notifyListeners();

        OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
        OneSignal.shared.setAppId("2aa54f4f-a694-4e71-a045-806b3c621769");
        OneSignal.shared
            .promptUserForPushNotificationPermission(fallbackToSettings: true);
        OneSignal.shared.sendTag('membership_no', result['user']['id']);
      // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
        OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
          print("Accepted permission: $accepted");
        });

      print(result['user']['email']);
      print(result['user']['name']);
      print(result['user']['phone_number']);
      print('login success');
    }
    return result;
  }

}
