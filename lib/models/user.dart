class User {
  final int? id;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final int? statusId;
  final int? userType;
  final int? mobileNo;

  User({this.id, this.email, this.createdAt, this.updatedAt, this.name, this.statusId, this.userType, this.mobileNo});

  factory User.copyWith(
    User user, {
    int? id,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    int? statusId,
    int? userType,
    int? mobileNo,
  }) {
    return User(
      id: id ?? user.id,
      email: email ?? user.email,
      createdAt: createdAt ?? user.createdAt,
      updatedAt: updatedAt ?? user.updatedAt,
      name: name ?? user.name,
      statusId: statusId ?? user.statusId,
      userType: userType ?? user.userType,
      mobileNo: mobileNo ?? user.mobileNo,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      email: json['email'] as String?,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      name: json['name'] as String?,
      statusId: json['status_id'] as int?,
      userType: json['user_type'] as int?,
      mobileNo: json['mobile_no'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'name': name,
      'status_id': statusId,
      'user_type': userType,
      'mobile_no': mobileNo,
    };
  }
}
