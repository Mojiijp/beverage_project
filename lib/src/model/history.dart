class Order {
  int id;
  int status;
  String slipImgPath;
  String slipImgFileType;
  String buyAt;
  String getAt;
  int cusId;
  int adminId;
  int amount;
  double totalPrice;
  // String checkAt;
  String createdAt;
  String updatedAt;
  List<MenuDetail> menuDetail;

  Order({
    required this.id,
    required this.status,
    required this.slipImgPath,
    required this.slipImgFileType,
    required this.buyAt,
    required this.getAt,
    required this.cusId,
    required this.adminId,
    required this.amount,
    required this.totalPrice,
    //required this.checkAt,
    required this.createdAt,
    required this.updatedAt,
    required this.menuDetail,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      status: json['status'],
      slipImgPath: json['slip_img_path'],
      slipImgFileType: json['slip_img_file_type'],
      buyAt: json['buy_at'],
      getAt: json['get_at'],
      cusId: json['cus_id'],
      adminId: json['admin_id'],
      amount: json['amount'],
      totalPrice: json['total_price'].toDouble(),
      //checkAt: json['check_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      menuDetail: List<MenuDetail>.from(json['menu_detail'].map((x) => MenuDetail.fromJson(x))),
    );
  }
}

class MenuDetail {
  int id;
  int bevId;
  int size;
  int sweetness;
  int orderId;
  String createdAt;
  String updatedAt;
  int status;
  double price;
  List<String> bevToppingAddInfo;
  BevInfo bevInfo;

  MenuDetail({
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

  factory MenuDetail.fromJson(Map<String, dynamic> json) {
    return MenuDetail(
      id: json['id'],
      bevId: json['bev_id'],
      size: json['size'],
      sweetness: json['sweetness'],
      orderId: json['order_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
      price: json['price'].toDouble(),
      bevToppingAddInfo: List<String>.from(json['bevtoppingadd_info']),
      bevInfo: BevInfo.fromJson(json['bev_info']),
    );
  }
}

class BevInfo {
  int id;
  String name;
  double price;
  String imagePath;
  int type;
  String fileType;
  String createdAt;
  String updatedAt;
  int status;

  BevInfo({
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

  factory BevInfo.fromJson(Map<String, dynamic> json) {
    return BevInfo(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imagePath: json['image_path'],
      type: json['type'],
      fileType: json['file_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
    );
  }
}