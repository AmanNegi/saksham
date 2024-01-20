import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:swaraksha/globals.dart';

class CameraSheet extends StatelessWidget {
  const CameraSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          height: 0.015 * getHeight(context),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: Text(
            "Pick a Source",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text('Camera'),
          onTap: () {
            Navigator.pop(context, 1);
          },
        ),
        ListTile(
          leading: Icon(MdiIcons.viewGallery),
          title: const Text('Gallery'),
          onTap: () {
            Navigator.pop(context, 0);
          },
        ),
        SizedBox(
          height: 0.15 * getHeight(context),
        ),
      ],
    );
  }
}
