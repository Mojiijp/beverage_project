// import 'package:beverage_project/src/model/menu.dart';
// import 'package:beverage_project/src/services/menu_service.dart';
// import 'package:get/get.dart';
//
// class MenuController1 extends GetxController{
//   var menu = <Menu>[].obs;
//
//   void fetchMenu() async {
//     MenuService request = MenuService();
//     request.menuService().then((response) {
//       if(response.statusCode == 200) {
//
//         for (var item in response.data) {
//           menu.add(Menu.fromJson(item));
//         }
//         print(response.statusCode);
//         print("load menu success");
//
//       } else {
//         print('Backend Error');
//       }
//     }).catchError((onError) {
//       printError();
//     });
//   }
// }