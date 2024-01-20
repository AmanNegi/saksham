import 'package:flutter/material.dart';
import 'package:swaraksha/colors.dart';

class FieldWrapper extends StatelessWidget {
  final Widget child;
  const FieldWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }
}
