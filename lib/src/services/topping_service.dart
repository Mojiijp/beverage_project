import 'package:beverage_project/src/model/topping.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ToppingService {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Topping>> fetchTopping() async {
    final SharedPreferences prefs = await _prefs;

    final response = await http.post(
        Uri.parse('http://192.168.1.10:8000/api/menu/topping_list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("token")}',
          "accept": "application/json",
          "Connection": "Keep-Alive"
        }
    );

    print("status code topping is : ${response.statusCode}");


    // เมื่อมีข้อมูลกลับมา
    if (response.statusCode == 200) {
      print("Load topping success");

      final topping = menuFromJson(response.body);
      print(topping);
      return (topping);

      // ส่งข้อมูลที่เป็น JSON String data ไปทำการแปลง เป็นข้อมูล List<Article
      // โดยใช้คำสั่ง compute ทำงานเบื้องหลัง เรียกใช้ฟังก์ชั่นชื่อ parseArticles
      // ส่งข้อมูล JSON String data ผ่านตัวแปร response.body
      //return compute(parseArticles, response.body);
    } else { // กรณี error
      throw Exception('Failed to load topping');
    }
  }
}