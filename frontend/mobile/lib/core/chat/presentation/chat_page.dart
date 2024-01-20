import 'package:flutter/material.dart';
import 'package:swaraksha/colors.dart';
import 'package:swaraksha/core/chat/application/chat_manager.dart';
import 'package:swaraksha/data/app_state.dart';
import 'package:swaraksha/dialogs/info_dialog.dart';
import 'package:swaraksha/models/message.dart';

import 'package:timeago/timeago.dart' as timeago;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];
  String message = "";
  bool isLoading = true;

  @override
  void initState() {
    getMessages();
    super.initState();
  }

  Future<void> getMessages() async {
    messages = await ChatManager().getMessages();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Announcements"),
        actions: [
          IconButton(
            onPressed: () {
              InfoDialog.showInfoDialog(
                context,
                "This is the announcements page. Here you can see all the announcements made by the admin.",
              );
            },
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20.0,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return MessageWidget(message: messages[index]);
                    },
                  ),
                ),
                AdminMessageBar(updatePageCallback: () => getMessages()),
              ],
            ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final Message message;
  const MessageWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColorFromPriority(message.priorityLevel),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                message.senderName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(message.message),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(
              timeago.format(message.sentAt),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: greyText),
            ),
          ),
        ],
      ),
    );
  }

  Color getColorFromPriority(String status) {
    if (status == "high") {
      return Colors.red[300]!;
    } else if (status == "medium") {
      return Colors.amber[300]!;
    }
    return Colors.lightBlue[200]!;
  }
}

class AdminMessageBar extends StatefulWidget {
  final Function updatePageCallback;
  const AdminMessageBar({super.key, required this.updatePageCallback});

  @override
  State<AdminMessageBar> createState() => _AdminMessageBarState();
}

class _AdminMessageBarState extends State<AdminMessageBar> {
  String message = "";
  @override
  Widget build(BuildContext context) {
    if (appState.value.userType == "admin") {
      return Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(color: cardColor, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1.0,
            blurRadius: 5.0,
            offset: const Offset(0.0, -5),
          )
        ]),
        child: TextField(
          controller: TextEditingController(text: message),
          onChanged: (value) {
            message = value;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter a Message",
            suffixIcon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: IconButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  await ChatManager().sendMessage(message);
                  message = "";
                  widget.updatePageCallback();
                },
                icon: const Icon(
                  Icons.send,
                  color: accentColor,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
