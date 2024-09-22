import 'package:flutter/material.dart';

class AppButtons extends StatelessWidget {
  const AppButtons(
      {super.key,
      required this.color,
      required this.backgroundColor,
      required this.borderColor,
      required this.size,
      this.text = 'hi',
      this.icon,
      this.isIcon = false});

  final Color color;
  final Color backgroundColor;
  final double size;
  final Color borderColor;
  final String? text;
  final IconData? icon;
  final bool? isIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: isIcon == false
          ? Center(child: Text(text!, style: TextStyle(color: color)))
          : Center(child: Icon(icon, color: color)),
    );
  }
}
