import 'dart:convert';
import 'dart:ffi';

List<Topping> menuFromJson(String str) =>
    List<Topping>.from(json.decode(str).map((x) => Topping.fromJson(x)));

String menuToJson(List<Topping> data) =>
    json.encode(List<Topping>.from(data.map((x) => x.toJson())));

class Topping {
  Topping({
    this.id,
    this.name,
    this.price,
    // this.updated_at,
    // this.create_at
  });

  int? id;
  String? name;
  int? price;

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
    id: json["id"],
    name: json["name"],
    price: json["price"]
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "price" : price
  };
}