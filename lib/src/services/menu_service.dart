import 'dart:convert';

import 'package:beverage_project/src/model/menu.dart';
import 'package:beverage_project/src/utils/api_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// class MenuService {
//   var dio = Dio();
//  
//   Future<dynamic> menuService() async {
//     return await dio.get('http//:127.0.0.1:8000/api/menu/menu_list');
//   }
// }

class MenuService {
  static final Future<SharedPreferences> _prefs = SharedPreferences
      .getInstance();

  /// ฟังก์ชั่นดึงข้อมูลจาก server โดยใช้ token
  static Future<Map<String, dynamic>> get(String token) async {
    final SharedPreferences prefs = await _prefs;
    var result;

    print("Menuuuuuuuuuuuuuuuuuuu");
    print('Bearer ' + token);

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
      result =
      result[0]; // เนื่องจากข้อมูลจาก api เป็น array เลยใช้เฉพาะข้อมูล key = 0
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


  Future<List<Menu>> fetchMenu(int type) async {
    final SharedPreferences prefs = await _prefs;

    var body = {
      "type": type,

    };

    final response = await http.post(
        Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndPoints.menu),
        //Uri.parse('http://192.168.1.10:8000/api/menu/menu_list_type'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("token")}',
          "accept": "application/json",
          "Connection": "Keep-Alive"
        }
    );

    print("status code menu is : ${response.statusCode}");


    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      print("Load menu success");

      final menu = menuFromJson(response.body);
      print(menu);
      return (menu);
    } else { // กรณี error
      throw Exception('Failed to load menu');
    }
  }
}