import 'dart:developer';

import 'package:flutter/material.dart';

class EditTextForm extends StatefulWidget {
  EditTextForm({
    this.hintText = '',
    required this.onChanged,
    this.validator,
    this.content = '',
    this.borderSelected = Colors.blue,
    this.borderUnSelected = Colors.grey,
    this.textColor = Colors.black,
    this.width = double.infinity,
    this.height = 60,
    this.label = '',
    this.errorText = '',
    this.error = false,
    this.obscureText = false,
    this.controller,
    this.typeKeyboard = TextInputType.text,
    this.onTap,
    this.autoFocus = false,
    this.maxLength,
    this.showEye = false,
    this.readOnly = false,
    this.smartDashesType,
    this.smartQuotesType,
  });
  String content;
  TextInputType typeKeyboard;
  Color borderSelected;
  Color borderUnSelected;
  Color textColor;
  double width;
  double height;
  String hintText;
  String errorText;
  String label;
  TextEditingController? controller;
  bool error;
  ValueChanged onChanged;
  Function()? onTap;
  String? Function(String?)? validator;
  bool obscureText;
  bool autoFocus;
  bool? showEye;
  int? maxLength;
  bool readOnly;
  SmartDashesType? smartDashesType;
  SmartQuotesType? smartQuotesType;

  @override
  _AppEdittextState createState() => _AppEdittextState();
}

class _AppEdittextState extends State<EditTextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 15),
      key: Key(widget.content.toString()),
      initialValue: widget.content,
      controller: widget.controller,
      autofocus: widget.autoFocus,
      keyboardType: widget.typeKeyboard,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      onTap: widget.onTap,
      // validator: widget.validator,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter some text';
      //   }
      //   return null;
      // },
      readOnly: widget.readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          labelStyle: TextStyle(color: widget.textColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: widget.showEye != null && widget.showEye == true
              ? IconButton(
                  icon: Icon(
                    widget.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.amberAccent,
                  ),
                  onPressed: () {
                    if (widget.obscureText) {
                      //
                    } else {
                      //
                    }
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                    log('bool: ${widget.obscureText}');
                  },
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: widget.borderSelected),
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }
}

class ObscuringTextEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      required bool withComposing,
      TextStyle? style}) {
    var displayValue = '•' * value.text.length;
    if (!value.composing.isValid || !withComposing) {
      return TextSpan(style: style, text: displayValue);
    }
    final TextStyle? composingStyle = style?.merge(
      const TextStyle(decoration: TextDecoration.underline),
    );
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: value.composing.textBefore(displayValue)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(displayValue),
        ),
        TextSpan(text: value.composing.textAfter(displayValue)),
      ],
    );
  }
}
