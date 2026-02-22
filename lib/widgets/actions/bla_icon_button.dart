import 'package:blarblarcar/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  const BlaIconButton({super.key, required this.icon, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(icon, size: BlaSize.icon, color: BlaColors.primary)
      ),
    );
  }
}
