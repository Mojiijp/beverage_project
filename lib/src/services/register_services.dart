import 'dart:convert';
import 'package:beverage_project/src/utils/api_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login.dart';

class RegisterService {
  static Future<Map<String, dynamic>> register(String email, String password, String name, String phone_number) async {
    var result;

    // ข้อมูลผู้ใช้ที่ต้องส่งไป
    final Map<String, dynamic> userData = {
      'email': email,
      'password': password,
      'name' : name,
      'phone_number' : phone_number
    };

    // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
    final response = await http.post(
      Uri.parse('http://192.168.1.10:8000/api/auth/register'), // ใช้ url จากค่าที่กำหนด
      body: json.encode(userData),
      headers: {'Content-Type': 'application/json'},
    );

    print(userData);
    print('Status code is ${response.statusCode}');

    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      var body = response.body;
      result = await json.decode(body);

      print(result);
      //final token = result['access_token'];
      //print('token is : ${token}');
      print('data create success');

    } else { // กรณี error
      throw Exception('Failed to load data');
    }
    return result;
  }

}




//
// class RegisterService {
//   TextEditingController _email = TextEditingController();
//   TextEditingController _phone = TextEditingController();
//   TextEditingController _userName = TextEditingController();
//   TextEditingController _password = TextEditingController();
//
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//
//   Future<void> register() async {
//     try {
//       var url = Uri.parse("http://10.0.2.2:8000/api/auth/register");
//       var headers = {
//         'Content-Type' : 'application/json',
//
//       };
//       Map body = {
//         'email' : _email.text.trim(),
//         'phone' : _phone.text,
//         'userName' : _userName.text,
//         'password' : _password.text
//       };
//
//       http.Response response =
//           await http.post(url, body: jsonEncode(body), headers: headers);
//
//       if(response.statusCode >= 200 && response.statusCode < 300 ) {
//       //if(response.statusCode < 200) {
//         final json = jsonDecode(response.body);
//         if(json['code'] == 0) {
//           var token = json['data']['token'];
//           print(token);
//           final SharedPreferences? prefs = await _prefs;
//
//           await prefs?.setString('token', token);
//           _email.clear();
//           _phone.clear();
//           _userName.clear();
//           _password.clear();
//           /// go to home
//         } else {
//           throw jsonDecode(response.body)['Message'] ?? "Unknown Error Occurred";
//         }
//       } else {
//         throw jsonDecode(response.body)['Message'] ?? "Unknown Error Occurred";
//       }
//     } catch (e) {
//       Get.back();
//       showDialog(
//           context: Get.context!,
//           builder: (context) {
//             return SimpleDialog(
//               title: Text("Error"),
//               contentPadding: EdgeInsets.all(20),
//               children: [Text(e.toString())],
//             );
//           }
//       );
//     }
//   }
// }

// class RegisterService {
//   // static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   //
//   // /// ฟังก์ชั่นดึงข้อมูลจาก server โดยใช้ token
//   // Future<Map<String, dynamic>> get(String token) async {
//   //   final SharedPreferences prefs = await _prefs;
//   //   var result;
//   //
//   //   // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
//   //   final response = await http.get(
//   //     Uri.parse('http://10.0.2.2:8000/api/auth/register'),
//   //     headers: {
//   //       'Content-Type': 'application/json',
//   //       "accept": "application/json",
//   //       'Authorization': 'Bearer $token'
//   //     },
//   //   );
//   //
//   //   // เมื่อมีข้อมูลกลับมา
//   //   if (response.statusCode == 200) {
//   //     var body = response.body;
//   //     result = await json.decode(body);
//   //     result = result[0]; // เนื่องจากข้อมูลจาก api เป็น array เลยใช้เฉพาะข้อมูล key = 0
//   //
//   //   } else { // กรณี error
//   //     throw Exception('Failed to load data');
//   //   }
//   //   return result;
//   // }
//
//   // /// ฟังก์ชั่นสำหรับสร้างบัญชีใหม่ โดยส่งค่าไปยัง server แล้วบันทึกลงฐานข้อมูล
//   // static Future<Login> create(String email, String password, String userName, String phone) async {
//   //   var result;
//   //
//   //   // ข้อมูลผู้ใช้ที่ต้องส่งไป
//   //   final Map<String, dynamic> userData = {
//   //     'email': email,
//   //     'password': password,
//   //     "name": userName,
//   //     "phone": phone
//   //   };
//   //
//   //   // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
//   //   final response = await http.post(
//   //     Uri.parse('http://10.0.2.2:8000/api/auth/register'), // ใช้ url จากค่าที่กำหนด
//   //     body: json.encode(userData),
//   //     headers: {'Content-Type': 'application/json'},
//   //   );
//   //
//   //   // เมื่อมีข้อมูลกลับมา
//   //   if (response.statusCode == 200) {
//   //     var body = response.body;
//   //     result = await json.decode(body);
//   //   } else { // กรณี error
//   //     throw Exception('Failed to load data ${response.statusCode}');
//   //   }
//   //   return result;
//   // }
//
//   static register(
//       String email, String password, String userName, String phone) async {
//     var url = Uri.parse('http://10.0.2.2:5000/crate');
//     var body = {
//       "email": email,
//       "password": password,
//       "name": userName,
//       "phone": phone
//     };
//     final res = await http.post(url,
//         headers: {
//           'content-type': 'application/json',
//           "accept": "application/json",
//         },
//         body: jsonEncode(body));
//     if (res.statusCode >= 200 && res.statusCode < 300) {
//       print(res.body);
//       return (true);
//     } else {
//       return (false);
//       print(res.reasonPhrase);
//     }
//   }
// }
