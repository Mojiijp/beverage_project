class ApiEndPoints {
  static const String baseUrl = "http://192.168.1.6:8000/api/";
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = "auth/register";
  final String login = "auth/login";
  final String menu = "menu/menu_list_type";
  final String topping = "menu/topping_list";
  final String orderIn = "menu/order_in";
  final String orderInCart = "menu/order_in_cart";
}