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
    this.padding = const EdgeInsets.all(0),
  });

  final Color? bgColor;
  final double borderRadius;
  final String labelText;
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

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
        child: Container(
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}

class AppTagCard extends StatefulWidget {
  const AppTagCard({
    super.key,
    this.bgColor,
    this.borderColor,
    this.borderRadius = 8,
    required this.child,
    this.width,
    this.height,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(4),
  });

  final Color? bgColor;
  final Color? borderColor;
  final double borderRadius;
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  @override
  State<AppTagCard> createState() => _AppTagCardState();
}

class _AppTagCardState extends State<AppTagCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.bgColor ?? Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
            color: widget.borderColor ?? Theme.of(context).colorScheme.primary),
      ),
      child: widget.child,
    );
  }
}
