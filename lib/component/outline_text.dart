import 'package:flutter/material.dart';

class AppOutlineText extends StatefulWidget {
  const AppOutlineText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.textColor = Colors.white,
    this.outlineColor = Colors.black,
    this.strokeWidth = 3,
  });
  final String text;
  final double fontSize;
  final Color textColor;
  final Color outlineColor;
  final double strokeWidth;

  @override
  State<AppOutlineText> createState() => _AppOutlineTextState();
}

class _AppOutlineTextState extends State<AppOutlineText> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = widget.strokeWidth
              ..color = widget.outlineColor,
          ),
        ),
        // Solid text as fill.
        Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.textColor,
          ),
        ),
      ],
    );
  }
}
