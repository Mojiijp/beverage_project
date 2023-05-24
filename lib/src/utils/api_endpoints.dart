class ApiEndPoints {
  static const String baseUrl = "http://192.168.1.4:8000/";
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = "api/auth/register";
  final String login = "api/auth/login";
}