// ignore_for_file: public_member_api_docs, sort_constructors_first
import "dart:convert";
import 'dart:convert';

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:swaraksha/constants.dart";
import "package:swaraksha/data/app_state.dart";

class HomeManager {
  static Future<Stats?> getStats() async {
    final res = await http.get(
      Uri.parse("$API_URL/issues/stats"),
    );
    debugPrint(res.body);

    if (res.statusCode == 200) {
      return Stats.fromMap(json.decode(res.body));
    } else {
      debugPrint("Error while sending message: ${res.body}");
      return null;
    }

  }
}

class Stats {
  final int totalIssuesClosedInLast7Days;
  final int totalIssuesOpenedInLast30Days;
  final int totalIssuesClosedInLast30Days;
  final int totalIssuesOpenedInLast7Days;
  Stats({
    required this.totalIssuesClosedInLast7Days,
    required this.totalIssuesOpenedInLast30Days,
    required this.totalIssuesClosedInLast30Days,
    required this.totalIssuesOpenedInLast7Days,
  });


  Stats copyWith({
    int? totalIssuesClosedInLast7Days,
    int? totalIssuesOpenedInLast30Days,
    int? totalIssuesClosedInLast30Days,
    int? totalIssuesOpenedInLast7Days,
  }) {
    return Stats(
      totalIssuesClosedInLast7Days: totalIssuesClosedInLast7Days ?? this.totalIssuesClosedInLast7Days,
      totalIssuesOpenedInLast30Days: totalIssuesOpenedInLast30Days ?? this.totalIssuesOpenedInLast30Days,
      totalIssuesClosedInLast30Days: totalIssuesClosedInLast30Days ?? this.totalIssuesClosedInLast30Days,
      totalIssuesOpenedInLast7Days: totalIssuesOpenedInLast7Days ?? this.totalIssuesOpenedInLast7Days,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalIssuesClosedInLast7Days': totalIssuesClosedInLast7Days,
      'totalIssuesOpenedInLast30Days': totalIssuesOpenedInLast30Days,
      'totalIssuesClosedInLast30Days': totalIssuesClosedInLast30Days,
      'totalIssuesOpenedInLast7Days': totalIssuesOpenedInLast7Days,
    };
  }

  factory Stats.fromMap(Map<String, dynamic> map) {
    return Stats(
      totalIssuesClosedInLast7Days: map['totalIssuesClosedInLast7Days'] as int,
      totalIssuesOpenedInLast30Days: map['totalIssuesOpenedInLast30Days'] as int,
      totalIssuesClosedInLast30Days: map['totalIssuesClosedInLast30Days'] as int,
      totalIssuesOpenedInLast7Days: map['totalIssuesOpenedInLast7Days'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Stats.fromJson(String source) => Stats.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Stats(totalIssuesClosedInLast7Days: $totalIssuesClosedInLast7Days, totalIssuesOpenedInLast30Days: $totalIssuesOpenedInLast30Days, totalIssuesClosedInLast30Days: $totalIssuesClosedInLast30Days, totalIssuesOpenedInLast7Days: $totalIssuesOpenedInLast7Days)';
  }

  @override
  bool operator ==(covariant Stats other) {
    if (identical(this, other)) return true;
  
    return 
      other.totalIssuesClosedInLast7Days == totalIssuesClosedInLast7Days &&
      other.totalIssuesOpenedInLast30Days == totalIssuesOpenedInLast30Days &&
      other.totalIssuesClosedInLast30Days == totalIssuesClosedInLast30Days &&
      other.totalIssuesOpenedInLast7Days == totalIssuesOpenedInLast7Days;
  }

  @override
  int get hashCode {
    return totalIssuesClosedInLast7Days.hashCode ^
      totalIssuesOpenedInLast30Days.hashCode ^
      totalIssuesClosedInLast30Days.hashCode ^
      totalIssuesOpenedInLast7Days.hashCode;
  }
}
