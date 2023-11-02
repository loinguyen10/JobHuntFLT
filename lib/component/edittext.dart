import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../value/style.dart';

class EditTextForm extends StatefulWidget {
  EditTextForm({
    this.hintText = '',
    required this.onChanged,
    this.validator,
    this.content = '',
    this.borderSelected,
    this.textColor,
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
    // this.textInputFormater,
    this.showEye = false,
    this.readOnly = false,
    this.maxLines = 1,
  });
  String content;
  TextInputType typeKeyboard;
  Color? borderSelected;
  Color? textColor;
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
  int maxLines;
  // List<TextInputFormatter>? textInputFormater;

  @override
  _AppEdittextState createState() => _AppEdittextState();
}

class _AppEdittextState extends State<EditTextForm> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: widget.height,
      width: widget.width,
      child: TextFormField(
        // inputFormatters: widget.textInputFormater,
        style: TextStyle(
            fontSize: 15, color: Theme.of(context).colorScheme.primary),
        key: Key(widget.content.toString()),
        initialValue: widget.content,
        controller: widget.controller,
        autofocus: widget.autoFocus,
        maxLines: widget.maxLines,
        keyboardType: widget.typeKeyboard,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        maxLength: widget.maxLength,
        onTap: widget.onTap,
        cursorColor: Colors.black,
        // focusNode: FocusNode(),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return Keystring.dont_empty.tr;
        //   }
        //   return null;
        // },
        readOnly: widget.readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.inversePrimary,
            labelText: widget.label,
            hintText: widget.hintText,
            // hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(
              color: widget.textColor ?? Theme.of(context).colorScheme.primary,
            ),
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
              borderSide: BorderSide(
                width: 1,
                color: widget.borderSelected ??
                    Theme.of(context).colorScheme.primary,
              ),
              borderRadius: BorderRadius.circular(8),
            )),
      ),
    );
  }
}
