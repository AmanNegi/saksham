import 'package:flutter/material.dart';
import 'package:swaraksha/globals.dart';

class LoadingLayout extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const LoadingLayout({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: AbsorbPointer(
          absorbing: isLoading,
          child: Opacity(
            opacity: isLoading ? 0.5 : 1,
            child: child,
          ),
        ),
      ),
      if (isLoading)
        const Center(
          child: CircularProgressIndicator(),
        ),
    ]);
  }
}
