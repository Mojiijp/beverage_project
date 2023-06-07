class Noti {
  int id;
  int userId;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  Noti({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Noti.fromJson(Map<String, dynamic> json) {
    return Noti(
      id: json['id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}