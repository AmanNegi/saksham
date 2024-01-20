// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Issue {
  IssueLocation location;
  String id;
  String title;
  String description;
  String status;
  String department;
  String departmentName;
  List<dynamic> images;
  String issuedBy;
  DateTime createdAt;

  Issue({
    required this.location,
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.department,
    required this.images,
    required this.issuedBy,
    required this.createdAt,
    required this.departmentName,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        location: IssueLocation.fromJson(json["location"]),
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        department: json["department"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        issuedBy: json["issuedBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        departmentName: json["departmentName"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "_id": id,
        "title": title,
        "description": description,
        "status": status,
        "department": department,
        "departmentName": departmentName,
        "images": List<dynamic>.from(images.map((x) => x)),
        "issuedBy": issuedBy,
        "createdAt": createdAt.toIso8601String(),
      };

  Issue copyWith({
    IssueLocation? location,
    String? id,
    String? title,
    String? description,
    String? status,
    String? department,
    List<dynamic>? images,
    String? issuedBy,
    String? departmentName,
    DateTime? createdAt,
  }) {
    return Issue(
      location: location ?? this.location,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      department: department ?? this.department,
      images: images ?? this.images,
      issuedBy: issuedBy ?? this.issuedBy,
      createdAt: createdAt ?? this.createdAt,
      departmentName: departmentName ?? this.departmentName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      '_id': id,
      'title': title,
      'description': description,
      'status': status,
      'department': department,
      'images': images,
      'issuedBy': issuedBy,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'departmentName': departmentName,
    };
  }

  factory Issue.fromMap(Map<String, dynamic> map) {
    return Issue(
      location: IssueLocation.fromMap(map['location'] as Map<String, dynamic>),
      id: map['_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      department: map['department'] as String,
      images: List<dynamic>.from((map['images'] as List<dynamic>)),
      issuedBy: map['issuedBy'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      departmentName: map["departmentName"] as String,
    );
  }

  @override
  String toString() {
    return 'Issue(location: $location, id: $id, title: $title, description: $description, status: $status, department: $department, images: $images, issuedBy: $issuedBy, createdAt: $createdAt, departmentName: $departmentName)';
  }

  @override
  bool operator ==(covariant Issue other) {
    if (identical(this, other)) return true;

    return other.location == location &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.status == status &&
        other.department == department &&
        listEquals(other.images, images) &&
        other.issuedBy == issuedBy &&
        other.createdAt == createdAt &&
        other.departmentName == departmentName;
  }

  @override
  int get hashCode {
    return location.hashCode ^
        id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        status.hashCode ^
        department.hashCode ^
        images.hashCode ^
        issuedBy.hashCode ^
        createdAt.hashCode ^
        departmentName.hashCode;
  }
}

class IssueLocation {
  String type;
  List<double> coordinates;

  IssueLocation({
    required this.type,
    required this.coordinates,
  });

  factory IssueLocation.fromJson(Map<String, dynamic> json) => IssueLocation(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };

  IssueLocation copyWith({
    String? type,
    List<double>? coordinates,
  }) {
    return IssueLocation(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'coordinates': coordinates,
    };
  }

  factory IssueLocation.fromMap(Map<String, dynamic> map) {
    return IssueLocation(
      type: map['type'] as String,
      // coordinates: List<double>.from((map['coordinates'] as List<double>)),
      coordinates: (map['coordinates'] as List<dynamic>)
          .map<double>((item) => item.toDouble())
          .toList(),
    );
  }

  @override
  String toString() => 'Location(type: $type, coordinates: $coordinates)';

  @override
  bool operator ==(covariant IssueLocation other) {
    if (identical(this, other)) return true;

    return other.type == type && listEquals(other.coordinates, coordinates);
  }

  @override
  int get hashCode => type.hashCode ^ coordinates.hashCode;
}
