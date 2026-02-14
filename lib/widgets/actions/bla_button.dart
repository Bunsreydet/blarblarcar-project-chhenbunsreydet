import 'package:blarblarcar/theme/theme.dart';
import 'package:flutter/material.dart';

enum BlaButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  const BlaButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.type,
    required this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final BlaButtonType type;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = type == BlaButtonType.primary
        ? BlaColors.primary
        : BlaColors.white;

    BorderSide border = type == BlaButtonType.primary
        ? BorderSide.none
        : BorderSide(color: BlaColors.greyLight, width: 2);
    Color textColor = type == BlaButtonType.primary
        ? BlaColors.white
        : BlaColors.primary;
    Color iconColor = type == BlaButtonType.primary
        ? BlaColors.white
        : BlaColors.primary;

    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(icon, size: 20, color: iconColor));
      children.add(SizedBox(width: BlaSpacings.s));
    }

    Text buttonText = Text(
      text,
      style: BlaTextStyles.button.copyWith(color: textColor),
    );

    children.add(buttonText);

    return SizedBox(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
          ),
          side: border,
        ),
        onPressed: onPressed, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
