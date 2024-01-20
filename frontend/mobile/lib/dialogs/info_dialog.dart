import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String info;

  const InfoDialog({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Info'),
      content: Text(info),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  static Future<void> showInfoDialog(BuildContext context, String info) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return InfoDialog(info: info);
      },
    );
  }
}
