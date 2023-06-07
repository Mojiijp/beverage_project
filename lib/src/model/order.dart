import 'dart:convert';

import 'package:beverage_project/src/model/menu.dart';

// List<Order> orderInCartFromJson(String str) =>
//     List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));
//
// String orderInCartToJson(List<Order> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Order {
//   final int id;
//   int? status;
//   Null? slipImgPath;
//   Null? slipImgFileType;
//   Null? buyAt;
//   Null? getAt;
//   int? cusId;
//   int? adminId;
//   Null? amount;
//   Null? totalPrice;
//   Null? checkAt;
//   String? createdAt;
//   String? updatedAt;
//   List<MenuDetail>? menuDetail;
//
//   Order({
//     required this.id,
//     this.status,
//     this.slipImgPath,
//     this.slipImgFileType,
//     this.buyAt,
//     this.getAt,
//     this.cusId,
//     this.adminId,
//     this.amount,
//     this.totalPrice,
//     this.checkAt,
//     this.createdAt,
//     this.updatedAt,
//     this.menuDetail
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//         id : json['id'],
//         status : json['status'],
//         slipImgPath : json['slip_img_path'],
//         slipImgFileType : json['slip_img_file_type'],
//         buyAt : json['buy_at'],
//         getAt : json['get_at'],
//         cusId : json['cus_id'],
//         adminId : json['admin_id'],
//         amount : json['amount'],
//         totalPrice : json['total_price'],
//         checkAt : json['check_at'],
//         createdAt : json['created_at'],
//         updatedAt : json['updated_at'],
//         menuDetail: json['menu_detail']
//
//         // if (json['menu_detail'] != null) {
//         //   menuDetail = <MenuDetail>[];
//         //   json['menu_detail'].forEach((v) {
//         //     menuDetail!.add(new MenuDetail.fromJson(v));
//         //   });
//         // }
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['status'] = this.status;
//     data['slip_img_path'] = this.slipImgPath;
//     data['slip_img_file_type'] = this.slipImgFileType;
//     data['buy_at'] = this.buyAt;
//     data['get_at'] = this.getAt;
//     data['cus_id'] = this.cusId;
//     data['admin_id'] = this.adminId;
//     data['amount'] = this.amount;
//     data['total_price'] = this.totalPrice;
//     data['check_at'] = this.checkAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.menuDetail != null) {
//       data['menu_detail'] = this.menuDetail!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class MenuDetail {
//   int? id;
//   int? bevId;
//   int? size;
//   int? sweetness;
//   int? orderId;
//   String? createdAt;
//   String? updatedAt;
//   int? price;
//   List<String>? bevtoppingaddInfo;
//   BevInfo? bevInfo;
//
//   MenuDetail(
//       {this.id,
//         this.bevId,
//         this.size,
//         this.sweetness,
//         this.orderId,
//         this.createdAt,
//         this.updatedAt,
//         this.price,
//         this.bevtoppingaddInfo,
//         this.bevInfo});
//
//   MenuDetail.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     bevId = json['bev_id'];
//     size = json['size'];
//     sweetness = json['sweetness'];
//     orderId = json['order_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     price = json['price'];
//     bevtoppingaddInfo = json['bevtoppingadd_info'].cast<String>();
//     bevInfo = json['bev_info'] != null
//         ? new BevInfo.fromJson(json['bev_info'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['bev_id'] = this.bevId;
//     data['size'] = this.size;
//     data['sweetness'] = this.sweetness;
//     data['order_id'] = this.orderId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['price'] = this.price;
//     data['bevtoppingadd_info'] = this.bevtoppingaddInfo;
//     if (this.bevInfo != null) {
//       data['bev_info'] = this.bevInfo!.toJson();
//     }
//     return data;
//   }
// }
//
// class BevInfo {
//   int? id;
//   String? name;
//   int? price;
//   String? imagePath;
//   int? type;
//   String? fileType;
//   String? createdAt;
//   String? updatedAt;
//
//   BevInfo(
//       {this.id,
//         this.name,
//         this.price,
//         this.imagePath,
//         this.type,
//         this.fileType,
//         this.createdAt,
//         this.updatedAt});
//
//   BevInfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     price = json['price'];
//     imagePath = json['image_path'];
//     type = json['type'];
//     fileType = json['file_type'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['image_path'] = this.imagePath;
//     data['type'] = this.type;
//     data['file_type'] = this.fileType;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

//Order orderResponseFromJson(String str) =>  Order.fromJson(json.decode(str));

    //List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));



//String orderResponseToJson(Order data) => json.encode(data.toJson());
//
// class Order {
//   int id;
//   int status;
//   // final String slipImgPath;
//   // final String slipImgPathType;
//   // final DateTime buyAt;
//   List<MenuDetail> menuDetail;
//
//   Order({
//     required this.id,
//     required this.status,
//     required this.menuDetail,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       id: json['id'],
//       status: json['status'],
//       //menuDetail: json['menu_detail'],
//       menuDetail: List<MenuDetail>.from(json["menu_detail"].map((x) => MenuDetail.fromJson(x))),
//
//       //MenuDetail.fromJson(json['menu_detail'])
//
//     );
//   }
// }
//
// class MenuDetail {
//   final int id;
//   final int size;
//   final int sweetness;
//   final int price;
//   final List topping;
//   final int status;
//   final BevInfo bevInfo;
//
//   const MenuDetail({
//     required this.id,
//     required this.size,
//     required this.sweetness,
//     required this.price,
//     required this.topping,
//     required this.status,
//     required this.bevInfo,
//   });
//
//   factory MenuDetail.fromJson(Map<String, dynamic> json) => MenuDetail(
//     id: json['id'],
//     size: json['size'],
//     topping: json['bevtoppingadd_info'],
//     sweetness: json['sweetness'],
//     price: json['price'],
//     status: json['status'],
//     bevInfo: BevInfo.fromJson(json['bev_info'])
//     //List<BevInfo>.from(json["bev_info"].map((x) => BevInfo.fromJson(x)))
//   );
// }
//
// class BevInfo {
//   final int id;
//   final String name;
//   final int price;
//   final int status;
//
//   const BevInfo({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.status
//   });
//
//   factory BevInfo.fromJson(Map<String, dynamic> json) => BevInfo(
//     id: json['id'],
//     name: json['name'],
//     price: json['price'],
//     status: json['status']
//   );
// }

class MyDataModel {
  final int id;
  final int status;
  final int cusId;
  final int adminId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MenuDetailModel> menuDetail;

  MyDataModel({
    required this.id,
    required this.status,
    required this.cusId,
    required this.adminId,
    required this.createdAt,
    required this.updatedAt,
    required this.menuDetail,
  });

  factory MyDataModel.fromJson(Map<String, dynamic> json) {
    return MyDataModel(
      id: json['id'],
      status: json['status'],
      cusId: json['cus_id'],
      adminId: json['admin_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      menuDetail: List<MenuDetailModel>.from(json['menu_detail'].map((x) => MenuDetailModel.fromJson(x))),
    );
  }
}

class MenuDetailModel {
  final int id;
  final int bevId;
  final int size;
  final int sweetness;
  final int orderId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int status;
  final double price;
  final List<String> bevToppingAddInfo;
  final BevInfoModel bevInfo;

  MenuDetailModel({
    required this.id,
    required this.bevId,
    required this.size,
    required this.sweetness,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.price,
    required this.bevToppingAddInfo,
    required this.bevInfo,
  });

  factory MenuDetailModel.fromJson(Map<String, dynamic> json) {
    return MenuDetailModel(
      id: json['id'],
      bevId: json['bev_id'],
      size: json['size'],
      sweetness: json['sweetness'],
      orderId: json['order_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      status: json['status'],
      price: json['price']?.toDouble(),
      bevToppingAddInfo: List<String>.from(json['bevtoppingadd_info']),
      bevInfo: BevInfoModel.fromJson(json['bev_info']),
    );
  }
}

class BevInfoModel {
  final int id;
  final String name;
  final double price;
  final String imagePath;
  final int type;
  final String fileType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int status;

  BevInfoModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.type,
    required this.fileType,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory BevInfoModel.fromJson(Map<String, dynamic> json) {
    return BevInfoModel(
      id: json['id'],
      name: json['name'],
      price: json['price']?.toDouble(),
      imagePath: json['image_path'],
      type: json['type'],
      fileType: json['file_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      status: json['status'],
    );
  }
}