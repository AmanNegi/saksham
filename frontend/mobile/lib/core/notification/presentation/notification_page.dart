import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:swaraksha/core/notification/application/notification_manager.dart';
import 'package:swaraksha/widgets/loading_layout.dart';
import "package:timeago/timeago.dart" as timeago;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isLoading = true;
  Notifications? notifications;

  @override
  void initState() {
    super.initState();
    GetIt.instance.get<NotificationManager>().getNotifications().then((value) {
      isLoading = false;
      notifications = value;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Notifications")),
        body: LoadingLayout(
          isLoading: isLoading,
          child: SingleChildScrollView(
            child: notifications == null
                ? Container()
                : Column(
                    children: notifications!.notifications
                        .map((e) => _getNotification(e))
                        .toList(),
                  ),
          ),
        ));
  }

  Widget _getNotification(NotificationItem e) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.black.withOpacity(0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e.message,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            timeago.format(e.addedAt),
          ),
          const SizedBox(height: 20),
          ButtonBar(
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.loop),
                label: const Text("Re-open"),
                onPressed: () async {},
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text("Resolve"),
                onPressed: () async {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
