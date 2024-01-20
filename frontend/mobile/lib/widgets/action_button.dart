import 'package:flutter/material.dart';
import 'package:swaraksha/colors.dart';
import 'package:swaraksha/globals.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        height: 0.065 * getHeight(context),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
