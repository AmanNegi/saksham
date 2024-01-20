import 'package:flutter/material.dart';
import 'package:swaraksha/colors.dart';
import 'package:swaraksha/globals.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;
  final Widget? child;
  final bool shrink;

  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.shrink = true,
    this.color = accentColor,
    this.child,
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
          borderRadius: BorderRadius.circular(60.0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              child ?? Container(),
              child != null ? const SizedBox(width: 10) : Container(),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
