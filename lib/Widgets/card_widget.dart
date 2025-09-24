import 'dart:ui';

import 'package:flutter/cupertino.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const BaseCard({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: CupertinoColors.white.withOpacity(0.3),
                  width: 1.2,
                ),
                gradient: LinearGradient(
                  colors: [
                    CupertinoColors.white.withOpacity(0.25),
                    CupertinoColors.white.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
