import 'package:flutter/cupertino.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const BaseCard({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.9),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
