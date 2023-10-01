import 'package:flutter/material.dart';

class AppBorderFrame extends StatefulWidget {
  const AppBorderFrame({
    super.key,
    this.bgColor = Colors.white,
    this.borderRadius = 8,
    required this.labelText,
    required this.child,
    this.width,
    this.height,
  });

  final Color bgColor;
  final double borderRadius;
  final String labelText;
  final Widget child;
  final double? width;
  final double? height;

  @override
  State<AppBorderFrame> createState() => _AppBorderFrameState();
}

class _AppBorderFrameState extends State<AppBorderFrame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(widget.borderRadius)),
      child: InputDecorator(
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}