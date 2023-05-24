import 'dart:convert';
import 'dart:ffi';

List<Menu> menuFromJson(String str) =>
    List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

String menuToJson(List<Menu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Menu {
  Menu({
    this.id,
    this.name,
    this.price,
    this.image_path,
    this.type,
    this.file_type,
    // this.updated_at,
    // this.create_at
  });

  int? id;
  String? name;
  int? price;
  String? image_path;
  int? type;
  String? file_type;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image_path: json["image_path"],
    type: json["type"],
    file_type: json["file_type"]
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "price" : price,
    "image_path" : image_path,
    "type" : type,
    "file_type" : file_type
  };
}