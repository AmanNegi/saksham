// ignore_for_file: public_member_api_docs, sort_constructors_first
import "dart:convert";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:swaraksha/constants.dart";
import "package:swaraksha/data/app_state.dart";

ValueNotifier<int> notificationCount = ValueNotifier(0);

class NotificationManager {
  bool detachPoller = false;

  Future<void> attachPoller() async {
    debugPrint("Attaching poller");
    while (!detachPoller) {
      await Future.delayed(const Duration(seconds: 10));
      await getNotificationCount();
    }
    debugPrint("Detaching poller");
  }

  Future<int> getNotificationCount() async {
    if (appState.value.uid == null) return 0;

    final res = await http.get(
      Uri.parse("$API_URL/notifications/getCount/${appState.value.uid}"),
    );
    debugPrint(res.body);
    if (res.statusCode == 200) {
      notificationCount.value = json.decode((res.body))["count"];
      return notificationCount.value;
    } else {
      debugPrint("Error getting count: ${res.body}");
      return 0;
    }
  }

  Future<Notifications?> getNotifications() async {
    if (appState.value.uid == null) return null;

    final res = await http.get(
      Uri.parse("$API_URL/notifications/${appState.value.uid}"),
    );

    debugPrint(res.body);

    if (res.statusCode == 200) {
      return Notifications.fromMap(json.decode(res.body));
    } else {
      debugPrint("Error while sending message: ${res.body}");
      return null;
    }
  }

  
}

class Notifications {
  final String id;
  final List<NotificationItem> notifications;
  Notifications({
    required this.id,
    required this.notifications,
  });

  Notifications copyWith({
    String? id,
    List<NotificationItem>? notifications,
  }) {
    return Notifications(
      id: id ?? this.id,
      notifications: notifications ?? this.notifications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'notifications': notifications.map((x) => x.toMap()).toList(),
    };
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      id: map['_id'] as String,
      notifications: List<NotificationItem>.from(
        (map['notifications']).map<NotificationItem>(
          (x) => NotificationItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Notifications.fromJson(String source) =>
      Notifications.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Notifications(id: $id, notifications: $notifications)';

  @override
  bool operator ==(covariant Notifications other) {
    if (identical(this, other)) return true;

    return other.id == id && listEquals(other.notifications, notifications);
  }

  @override
  int get hashCode => id.hashCode ^ notifications.hashCode;
}

class NotificationItem {
  final bool viewed;
  final String message;
  final String issueId;
  final String id;
  final DateTime addedAt;
  NotificationItem({
    required this.viewed,
    required this.message,
    required this.issueId,
    required this.id,
    required this.addedAt,
  });

  NotificationItem copyWith({
    bool? viewed,
    String? message,
    String? issueId,
    String? id,
    DateTime? addedAt,
  }) {
    return NotificationItem(
      viewed: viewed ?? this.viewed,
      message: message ?? this.message,
      issueId: issueId ?? this.issueId,
      id: id ?? this.id,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'viewed': viewed,
      'message': message,
      'issueId': issueId,
      '_id': id,
      'addedAt': addedAt.millisecondsSinceEpoch,
    };
  }

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    return NotificationItem(
      viewed: map['viewed'] as bool,
      message: map['message'] as String,
      issueId: map['issueId'] as String,
      id: map['_id'] as String,
      addedAt: DateTime.parse(map['addedAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationItem.fromJson(String source) =>
      NotificationItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notification(viewed: $viewed, message: $message, issueId: $issueId, id: $id, addedAt: $addedAt)';
  }

  @override
  bool operator ==(covariant NotificationItem other) {
    if (identical(this, other)) return true;

    return other.viewed == viewed &&
        other.message == message &&
        other.issueId == issueId &&
        other.id == id &&
        other.addedAt == addedAt;
  }

  @override
  int get hashCode {
    return viewed.hashCode ^
        message.hashCode ^
        issueId.hashCode ^
        id.hashCode ^
        addedAt.hashCode;
  }
}

NotificationManager notificationManager = NotificationManager();
