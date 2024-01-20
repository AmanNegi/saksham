import 'package:flutter/material.dart';
import 'package:swaraksha/widgets/back_layout.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;
  const FullScreenImagePage({
    super.key,
    required this.imageUrl,
  });

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  @override
  Widget build(BuildContext context) {
    return BackLayout(
      child: InteractiveViewer(
        child: Image.network(
          widget.imageUrl,
        )
      ),
    );
  }
}
