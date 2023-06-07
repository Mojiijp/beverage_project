class Status {
  int id;
  int status;
  String createdAt;
  String updatedAt;

  Status({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}