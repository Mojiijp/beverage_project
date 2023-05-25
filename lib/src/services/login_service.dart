import 'dart:convert';
import 'package:beverage_project/src/utils/api_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
      Uri.parse('http://192.168.1.10:8000/api/auth/login'),
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

      print(result['user']['email']);
      print(result['user']['name']);
      print(result['user']['phone_number']);
      print('login success');
    }
    return result;
  }


}






// class LoginService {
//   TextEditingController _email = TextEditingController();
//   TextEditingController _password = TextEditingController();
//
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//
//   Future<void> login() async {
//     try {
//       var url = Uri.parse("http://10.0.2.2:8000/api/auth/login");
//       var headers = {'Content-Type' : 'application/json'};
//       Map body = {
//         'email' : _email.text.trim(),
//         'password' : _password.text
//       };
//
//       http.Response response =
//       await http.post(url, body: jsonEncode(body), headers: headers);
//
//       if(response.statusCode >= 200 && response.statusCode < 300 ) {
//         final json = jsonDecode(response.body);
//         if(json['code'] == 0) {
//           var token = json['data']['token'];
//           print(token);
//           final SharedPreferences? prefs = await _prefs;
//
//           await prefs?.setString('token', token);
//           _email.clear();
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
//             }
//       );
//       print(e.toString());
//     }
//   }
// }


// class LoginServices {
//   /// ใช้งานข้อมูล SharedPreferences
//   static final Future<SharedPreferences> _prefs =
//       SharedPreferences.getInstance();
//
//   /// ฟังก์ชั่นดึงสถานะการล็อกอิน จากข้อมูล SharedPreferences
//   Future<bool> getLoginStatus() async {
//     final SharedPreferences prefs = await _prefs;
//     return prefs.getBool('loginSuccess') ?? false;
//   }
//
//   /// ฟังก์ชั่นดึงข้อมูลผู้ใช้ทั่วไป จากข้อมูล SharedPreferences
//   Future<Data> getUser() async {
//     final SharedPreferences prefs = await _prefs;
//     return Data(
//         email: prefs.getString('email'),
//         name: prefs.getString('name'),
//         token: prefs.getString('token'));
//   }
//
//   /// ฟังก์ชั่นดึงข้อมูล token จากข้อมูล SharedPreferences
//   Future<String> getToken() async {
//     final SharedPreferences prefs = await _prefs;
//     String token = prefs.getString("user_token")!;
//     return token;
//   }
//
//   ///  ฟังก์ชั่นล็อกเอาท์ออกจากระบบ ล้างค่าข้อมูล SharedPreferences
//   Future<bool> logout() async {
//     final SharedPreferences prefs = await _prefs;
//     return await prefs.clear();
//   }
//
//   /// ฟังก์ชั่นดึงข้อมูลจาก server โดยใช้ token
//   Future<Map<String, dynamic>> get(String token) async {
//     final SharedPreferences prefs = await _prefs;
//     var result;
//
//     // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
//     final response = await http.get(
//       Uri.parse('http://10.0.2.2:8000/login'),
//       headers: {
//         'Content-Type': 'application/json',
//         "accept": "application/json",
//         'Authorization': 'Bearer $token'
//       },
//     );
//     print('token : $token');
//
//     // เมื่อมีข้อมูลกลับมา
//     if (response.statusCode == 200) {
//       var body = response.body;
//       result = await json.decode(body);
//       result = result[
//           0]; // เนื่องจากข้อมูลจาก api เป็น array เลยใช้เฉพาะข้อมูล key = 0
//     } else {
//       // กรณี error
//       throw Exception('Failed to load data');
//     }
//     return result;
//   }
//
//   /// ฟังก์ชั่นสำหรับทำการล็อกอิน โดยส่งค่าไปยัง server
//   static Future<Map<String, dynamic>> authen(
//       String email, String password) async {
//     final SharedPreferences prefs = await _prefs;
//     var result;
//
//     final Map<String, dynamic> loginData = {
//       'email': email,
//       'password': password
//     };
//
//     // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
//     final response = await http.post(
//       Uri.parse('http://10.0.2.2:8000/login'),
//       body: json.encode(loginData),
//       headers: {'Content-Type': 'application/json'},
//     );
//
//     // เมื่อมีข้อมูลกลับมา
//     if (response.statusCode == 200) {
//       var body = response.body;
//       result = await json.decode(body);
//       if (result['success'] != null) {
//         // กรณีมีข้อมูลกลับบมา และล็อกอินผ่าน
//         // บันทึกข้อมูลเบื้องต้นลงใน SharedPreferences
//         await prefs.setString("email", result['email']);
//         await prefs.setString("token", result['jwt']);
//         await prefs.setInt("user_token_expired", result['expireAt']);
//         await prefs.setBool("loginSuccess", true);
//       }
//     } else {
//       // กรณี error
//       throw Exception('Failed to load data ${response.statusCode}');
//     }
//     return result;
//   }
//
//   // static Future<Login> login(String email, String password) async {
//   //   var url = Uri.parse('http://10.0.2.2:5000/login');
//   //
//   //   var body = {
//   //     "email": email,
//   //     "password": password,
//   //   };
//   //   const storage = FlutterSecureStorage();
//   //   final res = await http.post(url,
//   //       headers: {
//   //         'content-type': 'application/json',
//   //         "accept": "application/json",
//   //         //'Authorization': 'Bearer $token'
//   //       },
//   //       body: jsonEncode(body));
//   //
//   //   if (res.statusCode >= 200 && res.statusCode < 300) {
//   //     final login = loginFromJson(res.body);
//   //
//   //     await storage.write(key: "jwt_token", value: login.data.token);
//   //     await storage.write(key: "user_name", value: login.data.name);
//   //     await storage.write(key: "user_email", value: login.data.email);
//   //     return (login);
//   //   } else {
//   //     throw Exception('Failed to login');
//   //     print(res.reasonPhrase);
//   //   }
//   // }
//
//   Future<http.Response> login(String email, String password) async {
//     var body = jsonEncode({'email': email, 'password': password});
//
//     http.Response response = await http.post(
//       Uri.parse('http://10.0.2.2:5000/login'),
//       headers: {
//         'content-type': 'application/json',
//         "accept": "application/json",
//         //'Authorization': 'Bearer $token'
//       },
//       body: jsonEncode(body)
//     );
//
//     return response;
//   }
//
// // Future<http.Response> logout(int id, String token) async {
// //   var body = jsonEncode({'id': id, 'token': token});
// //
// //   http.Response response = await http.post(super.logoutPath,
// //       headers: super.headers, body: body);
// //
// //   return response;
// // }
// }
