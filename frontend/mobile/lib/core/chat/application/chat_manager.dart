import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:swaraksha/constants.dart";
import "package:swaraksha/data/app_state.dart";
import "package:swaraksha/globals.dart";
import "package:swaraksha/models/message.dart";

class ChatManager {
  Future<void> sendMessage(String message) async {
    final res = await http.post(
      Uri.parse("$API_URL/chat/sendMessage/${appState.value.groupId}"),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "message": message,
        "sender": appState.value.uid,
        "senderName": appState.value.name,
      }),
    );
    debugPrint(res.body);

    if (res.statusCode == 200) {
      showToast("Message sent successfully");
    } else {
      debugPrint("Error while sending message: ${res.body}");
      showToast(res.body);
    }
  }

  Future<List<Message>> getMessages() async {
    final res = await http.get(
      Uri.parse("$API_URL/chat/${appState.value.groupId}"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    debugPrint(res.body);

    if (res.statusCode == 200) {
      List<Message> messages = [];
      Map body = json.decode(res.body);
      for (var item in body["messages"]) {
        messages.add(Message.fromMap(item));
      }

      // sort messages by timestamp
      messages.sort((a, b) => b.sentAt.compareTo(a.sentAt));  

      return messages;
    } else {
      debugPrint("Error while fetching messages: ${res.body}");
      showToast(res.body);
      return [];
    }
  }
}
