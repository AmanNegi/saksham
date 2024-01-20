import 'package:flutter/material.dart';
import 'package:swaraksha/globals.dart';

class BackLayout extends StatelessWidget {
  final Widget child;
  const BackLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: child,
      ),
      Positioned(
        left: 0.03 * getWidth(context),
        top: 0.06 * getHeight(context),
        child: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            child: const Center(
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
    ]);
  }
}
