import 'package:beverage_project/src/model/topping.dart';
import 'package:beverage_project/src/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ToppingService {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Topping>> fetchTopping() async {
    final SharedPreferences prefs = await _prefs;

    final response = await http.post(
        Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndPoints.topping),
        //Uri.parse('http://192.168.1.10:8000/api/menu/topping_list'),
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
    } else { // กรณี error
      throw Exception('Failed to load topping');
    }
  }
}