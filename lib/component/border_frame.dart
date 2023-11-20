import 'package:flutter/material.dart';

class AppBorderFrame extends StatefulWidget {
  const AppBorderFrame({
    super.key,
    this.bgColor,
    this.borderRadius = 8,
    this.labelText = '',
    required this.child,
    this.width,
    this.height,
    this.margin = const EdgeInsets.all(0),
  });

  final Color? bgColor;
  final double borderRadius;
  final String labelText;
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;

  @override
  State<AppBorderFrame> createState() => _AppBorderFrameState();
}

class _AppBorderFrameState extends State<AppBorderFrame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
          color: widget.bgColor ?? Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(widget.borderRadius)),
      child: InputDecorator(
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
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
