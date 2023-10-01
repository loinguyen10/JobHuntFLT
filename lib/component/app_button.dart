import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({
    required this.onPressed,
    this.content = '',
    this.bgColor = Colors.black,
    this.colorBorder = Colors.white,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 40,
    this.pathIm = '',
    this.fontSize = 14,
    this.disableBtn = false,
    this.rightIcon,
    this.padding,
    this.borderRadius = 8,
  });
  final GestureTapCallback onPressed;
  String content;
  Color bgColor;
  Color textColor;
  double width;
  double height;
  double fontSize;
  String pathIm;
  bool disableBtn;
  Color colorBorder;
  IconData? rightIcon;
  EdgeInsets? padding;
  double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
              content,
              style: TextStyle(color: textColor, fontSize: fontSize),
            ),
          ],
        ));
  }
}
