import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {

  Login({
    required this.data,
    required this.message,
    required this.token,
  });

  User data;
  User token;
  String message;


  factory Login.fromJson(Map<String, dynamic> json) => Login(
    data: User.fromJson(json["data"]),
    token: User.fromJson(json["token"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "token" : token
  };
}

class User {

  User({
    required this.email,
    required this.name,
    required this.token,
    required this.phone_number
  });

  String email;
  String name;
  String token;
  String phone_number;

  ///แปลงข้อมูลจาก JSON -> dynamic
  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json["email"],
    name: json["name"],
    token: json["token"],
    phone_number: json["phone_number"],
  );

  ///แปลงข้อมูลจาก Dynamic -> JSON
  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "phone_number" : phone_number,
    "token": token
  };
}