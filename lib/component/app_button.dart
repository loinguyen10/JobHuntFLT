import 'package:flutter/material.dart';
import 'package:jobhunt_ftl/value/style.dart';

class AppButton extends StatelessWidget {
  AppButton({
    required this.onPressed,
    this.label = '',
    this.bgColor = Colors.black,
    this.colorBorder = Colors.white,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = ParameterStyle.APP_BUTTON_HEIGHT_NORMAL,
    this.fontSize = ParameterStyle.FONT_SIZE_NORMAL,
    this.disableBtn = false,
    this.rightIcon,
    this.padding,
    this.margin,
    this.borderRadius = ParameterStyle.BORDER_RADIUS_NORMAL,
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
  EdgeInsets? padding;
  EdgeInsets? margin;
  double borderRadius;

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
            ],
          )),
    );
  }
}
