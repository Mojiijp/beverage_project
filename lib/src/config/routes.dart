import 'package:beverage_project/page/basket_screen.dart';
import 'package:beverage_project/page/menu/detail_screen.dart';
import 'package:beverage_project/page/order_screen.dart';
import 'package:beverage_project/src/model/menu.dart';
import 'package:beverage_project/src/widgets/buttom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:beverage_project/page/create_screen.dart';
import 'package:beverage_project/page/home_screen.dart';
import 'package:beverage_project/page/login_screen.dart';


class Routes {
  static const loginScreen = "/login";
  static const createScreen = "/create";
  static const bottomNavBar = "/bottom-nav-bar";
  static const homeScreen = "/home";
  static const detailScreen = "/detail";
  static const orderScreen = "/order";
  static const basketScreen = "/basket";

  static List<GetPage> getPageRoutes() {
    return [
      GetPage(
        name: loginScreen,
        page: () => LoginScreen(),
      ),
      GetPage(
        name: createScreen,
        page: () => const CreateScreen(),
      ),
      GetPage(
        name: bottomNavBar,
        page: () => const BottomNavBar(),
      ),
      GetPage(
        name: homeScreen,
        page: () => const HomeScreen(),
      ),
      GetPage(
        name: detailScreen,
        page: () => DetailScreen(),
      ),
      GetPage(
        name: orderScreen,
        page: () => const OrderScreen(),
      ),
      GetPage(
        name: basketScreen,
        page: () => const BasketScreen(),
      ),
    ];
  }
}