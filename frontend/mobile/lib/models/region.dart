import 'dart:convert';

import 'package:flutter/foundation.dart';

class Region {
  final String name;
  final String id;
  final List<SubRegion> subRegions;
  Region({
    required this.name,
    required this.id,
    required this.subRegions,
  });

  Region copyWith({
    String? name,
    String? id,
    List<SubRegion>? subRegions,
  }) {
    return Region(
      name: name ?? this.name,
      id: id ?? this.id,
      subRegions: subRegions ?? this.subRegions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      '_id': id,
      'subRegions': subRegions.map((x) => x.toMap()).toList(),
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      name: map['name'] as String,
      id: map['_id'] as String,
      subRegions: List<SubRegion>.from(
        (map['subRegions']).map<SubRegion>(
          (x) => SubRegion.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Region.fromJson(String source) =>
      Region.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Region(name: $name, id: $id, subRegions: $subRegions)';

  @override
  bool operator ==(covariant Region other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        listEquals(other.subRegions, subRegions);
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ subRegions.hashCode;
}

class SubRegion {
  final String name;
  final String id;
  final String groupId;
  final List<DepartmentNumber> numbers;

  SubRegion({
    required this.name,
    required this.id,
    required this.groupId,
    required this.numbers,
  });

  SubRegion copyWith({
    String? name,
    String? id,
    String? groupId,
    List<DepartmentNumber>? numbers,
  }) {
    return SubRegion(
      name: name ?? this.name,
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      numbers: numbers ?? this.numbers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      '_id': id,
      'groupId': groupId,
      'numbers': numbers.map((x) => x.toMap()).toList(),
    };
  }

  factory SubRegion.fromMap(Map<String, dynamic> map) {
    return SubRegion(
      name: map['name'] as String,
      id: map['_id'] as String,
      groupId: map['groupId'] as String,
      numbers: List<DepartmentNumber>.from(
        (map['numbers']).map<DepartmentNumber>(
          (x) => DepartmentNumber.fromMap(
            x as Map<String, dynamic>,
          ),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubRegion.fromJson(String source) =>
      SubRegion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubRegion(name: $name, id: $id, groupId: $groupId, numbers: $numbers)';
  }

  @override
  bool operator ==(covariant SubRegion other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.groupId == groupId &&
        listEquals(other.numbers, numbers);
  }

  @override
  int get hashCode {
    return name.hashCode ^ id.hashCode ^ groupId.hashCode ^ numbers.hashCode;
  }
}

class DepartmentNumber {
  String departmentId;
  String departmentName;
  String number;
  String id;

  DepartmentNumber({
    required this.departmentId,
    required this.departmentName,
    required this.number,
    required this.id,
  });

  DepartmentNumber copyWith({
    String? departmentId,
    String? departmentName,
    String? number,
    String? id,
  }) {
    return DepartmentNumber(
      departmentId: departmentId ?? this.departmentId,
      departmentName: departmentName ?? this.departmentName,
      number: number ?? this.number,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'departmentId': departmentId,
      'departmentName': departmentName,
      'number': number,
      '_id': id,
    };
  }

  factory DepartmentNumber.fromMap(Map<String, dynamic> map) {
    return DepartmentNumber(
      departmentId: map['departmentId'] as String,
      departmentName: map['departmentName'] as String,
      number: map['number'] as String,
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DepartmentNumber.fromJson(String source) =>
      DepartmentNumber.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DepartmentNumber(departmentId: $departmentId, departmentName: $departmentName, number: $number, id: $id)';
  }

  @override
  bool operator ==(covariant DepartmentNumber other) {
    if (identical(this, other)) return true;

    return other.departmentId == departmentId &&
        other.departmentName == departmentName &&
        other.number == number &&
        other.id == id;
  }

  @override
  int get hashCode {
    return departmentId.hashCode ^
        departmentName.hashCode ^
        number.hashCode ^
        id.hashCode;
  }
}
