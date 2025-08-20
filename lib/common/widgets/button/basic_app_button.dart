import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Widget? content;
  final double? height;
  final double? width;
  final Color? color;
  final ButtonStyle? style;
  const BasicAppButton({
    required this.onPressed,
    this.title = '',
    this.height,
    this.width,
    this.content,
    this.color,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:
          style ??
          ElevatedButton.styleFrom(
            minimumSize: Size(
              width ?? MediaQuery.of(context).size.width,
              height ?? 50,
            ),
          ),
      child:
          content ??
          Text(
            title,
            style: TextStyle(
              color: color ?? Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
    );
  }
}
