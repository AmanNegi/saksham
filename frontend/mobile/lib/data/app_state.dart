// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<AppState> appState = ValueNotifier(AppState.initial());

bool isAdmin() {
  return appState.value.userType == "admin";
}

class AppCache {
  final String _prefsKey = "app_state";

  Future<void> getDataFromDevice() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(_prefsKey);
    if (data == null) return;
    appState.value = (AppState.fromJson(data));
    debugPrint("Data From Device: $data");
  }

  saveDataToDevice() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_prefsKey, appState.value.toJson());
    debugPrint("Saved Data to Device...");
  }

  updateAppCache(AppState newState) {
    debugPrint(newState.toJson());
    appState.value = AppState.fromJson(newState.toJson());
    saveDataToDevice();
  }

  clearAppCache() {
    appState.value = AppState.initial();
    saveDataToDevice();
  }
}

/// [AppState] Stores App State and Credentials.

class AppState {
  final bool isLoggedIn;
  final String name;
  final String phone;
  final String department;

  final String? departmentId;
  final String? uid;
  final String? userType;

  final String? region;
  final String? subRegion;
  final String? groupId;

  AppState({
    required this.isLoggedIn,
    required this.name,
    required this.phone,
    required this.department,
    this.uid,
    this.userType,
    this.region,
    this.subRegion,
    this.groupId,
    this.departmentId,
  });

  factory AppState.initial() {
    return AppState(
      isLoggedIn: false,
      name: "",
      phone: "",
      department: "",
    );
  }

  AppState copyWith({
    bool? isLoggedIn,
    String? name,
    String? phone,
    String? department,
    String? uid,
    String? userType,
    String? region,
    String? subRegion,
    String? groupId,
    String? departmentId,
  }) {
    return AppState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      department: department ?? this.department,
      uid: uid ?? this.uid,
      userType: userType ?? this.userType,
      region: region ?? this.region,
      subRegion: subRegion ?? this.subRegion,
      groupId: groupId ?? this.groupId,
      departmentId: departmentId ?? this.departmentId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoggedIn': isLoggedIn,
      'name': name,
      'phone': phone,
      'department': department,
      '_id': uid,
      'userType': userType,
      'region': region,
      'subRegion': subRegion,
      'groupId': groupId,
      'departmentId': departmentId,
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      isLoggedIn: map['isLoggedIn'] as bool,
      name: map['name'] as String,
      phone: map['phone'] as String,
      department: map['department'] as String,
      uid: map['_id'] != null ? map['_id'] as String : null,
      userType: map['userType'] != null ? map['userType'] as String : null,
      region: map['region'] != null ? map['region'] as String : null,
      subRegion: map['subRegion'] != null ? map['subRegion'] as String : null,
      groupId: map['groupId'] != null ? map['groupId'] as String : null,
      departmentId:
          map['departmentId'] != null ? map['departmentId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) =>
      AppState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppState(isLoggedIn: $isLoggedIn, name: $name, phone: $phone, department: $department, uid: $uid, userType: $userType, region: $region, subRegion: $subRegion, groupId: $groupId, departmentId: $departmentId)';
  }

  @override
  bool operator ==(covariant AppState other) {
    if (identical(this, other)) return true;

    return other.isLoggedIn == isLoggedIn &&
        other.name == name &&
        other.phone == phone &&
        other.department == department &&
        other.uid == uid &&
        other.userType == userType &&
        other.region == region &&
        other.subRegion == subRegion &&
        other.groupId == groupId &&
        other.departmentId == departmentId;
  }

  @override
  int get hashCode {
    return isLoggedIn.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        department.hashCode ^
        uid.hashCode ^
        userType.hashCode ^
        region.hashCode ^
        subRegion.hashCode ^
        groupId.hashCode ^
        departmentId.hashCode;
  }
}
