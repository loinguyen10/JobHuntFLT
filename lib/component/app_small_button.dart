import 'package:flutter/material.dart';
import 'package:jobhunt_ftl/value/style.dart';

class AppSmallButton extends StatelessWidget {
  AppSmallButton({
    required this.onPressed,
    required this.label,
    this.bgColor = Colors.black,
    this.colorBorder = Colors.white,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 48,
    this.fontSize = 12,
    this.disableBtn = false,
    this.rightIcon,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
    this.margin,
    this.borderRadius = ParameterStyle.BORDER_RADIUS_NORMAL,
    required this.icon,
  });
  final GestureTapCallback onPressed;
  String label;
  Color bgColor;
  Color textColor;
  double width;
  double height;
  double fontSize;
  bool disableBtn;
  Color colorBorder;
  IconData? rightIcon;
  EdgeInsets padding;
  EdgeInsets? margin;
  double borderRadius;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
          onPressed: disableBtn == false ? onPressed : null,
          style: ElevatedButton.styleFrom(
              padding: padding,
              backgroundColor: disableBtn == false ? bgColor : Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius)),
              side: BorderSide(color: colorBorder, width: 1),
              minimumSize: Size(width, height)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon,
              Text(
                label,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
            ],
          )),
    );
  }
}
