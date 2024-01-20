import 'dart:convert';

class AppUser {
  final String name;
  final String phone;
  final String id;
  final String userType;

  AppUser({
    required this.name,
    required this.phone,
    required this.id,
    required this.userType,
  });

  AppUser copyWith({
    String? name,
    String? phone,
    String? id,
    String? userType,
  }) {
    return AppUser(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      id: id ?? this.id,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      '_id': id,
      'userType': userType,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] as String,
      phone: map['phone'] as String,
      id: map['_id'] as String,
      userType: map['userType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(name: $name, phone: $phone, id: $id, userType: $userType)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.id == id &&
        other.userType == userType;
  }

  @override
  int get hashCode {
    return name.hashCode ^ phone.hashCode ^ id.hashCode ^ userType.hashCode;
  }
}
