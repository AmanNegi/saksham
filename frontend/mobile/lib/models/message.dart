// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Message {
  String id;
  // Sender is Sender ID
  String sender;
  String senderName;
  String message;
  List<String> images;
  DateTime sentAt;
  String priorityLevel;
  Message({
    required this.id,
    required this.sender,
    required this.senderName,
    required this.message,
    required this.images,
    required this.sentAt,
    required this.priorityLevel,
  });

  Message copyWith({
    String? id,
    String? sender,
    String? senderName,
    String? message,
    List<String>? images,
    DateTime? sentAt,
    String? priorityLevel,
  }) {
    return Message(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      senderName: senderName ?? this.senderName,
      message: message ?? this.message,
      images: images ?? this.images,
      sentAt: sentAt ?? this.sentAt,
      priorityLevel: priorityLevel ?? this.priorityLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'sender': sender,
      'senderName': senderName,
      'message': message,
      'images': images,
      'sentAt': sentAt.millisecondsSinceEpoch,
      'priorityLevel': priorityLevel,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['_id'] as String,
      sender: map['sender'] as String,
      senderName: map['senderName'] as String,
      message: map['message'] as String,
      images: (map['images'] as List<dynamic>)
          .map((item) => item.toString())
          .toList(),
      sentAt: DateTime.parse(map['sentAt'] as String),
      priorityLevel: map['priorityLevel'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, sender: $sender, senderName: $senderName, message: $message, images: $images, sentAt: $sentAt, priorityLevel: $priorityLevel)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sender == sender &&
        other.senderName == senderName &&
        other.message == message &&
        listEquals(other.images, images) &&
        other.sentAt == sentAt &&
        other.priorityLevel == priorityLevel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sender.hashCode ^
        senderName.hashCode ^
        message.hashCode ^
        images.hashCode ^
        sentAt.hashCode ^
        priorityLevel.hashCode;
  }
}
