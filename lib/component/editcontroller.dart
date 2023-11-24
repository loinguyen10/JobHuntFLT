import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../value/style.dart';

class EditTextController extends StatefulWidget {
  EditTextController({
    this.hintText = '',
    required this.onChanged,
    this.borderSelected = Colors.black,
    this.borderUnSelected = Colors.black,
    this.textColor = Colors.black,
    this.width = double.infinity,
    this.height = 56,
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
    this.maxLines = 1,
  });
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
  bool obscureText;
  bool autoFocus;
  bool? showEye;
  int? maxLength;
  int maxLines;
  // List<TextInputFormatter>? textInputFormater;

  @override
  _AppEditControllerState createState() => _AppEditControllerState();
}

class _AppEditControllerState extends State<EditTextController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: widget.height,
      width: widget.width,
      child: TextFormField(
        // inputFormatters: widget.textInputFormater,
        style: TextStyle(fontSize: 15, color: Colors.black),
        controller: widget.controller,
        autofocus: widget.autoFocus,
        maxLines: widget.maxLines,
        keyboardType: widget.typeKeyboard,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        maxLength: widget.maxLength,
        onTap: widget.onTap,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: widget.label,
            hintText: widget.hintText,
            focusColor: Colors.black,
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: widget.textColor),
            // errorText: '',
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
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
                      color: appPrimaryColor,
                    ),
                    onPressed: () {
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
      ),
    );
  }
}
