import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/component/edittext.dart';

class AppAutocompleteEditText extends StatefulWidget {
  AppAutocompleteEditText({
    super.key,
    required this.listSuggestion,
    this.hintText = '',
    required this.onSelected,
    this.content = '',
    this.borderSelected,
    this.textColor,
    this.width = double.infinity,
    this.height = 56,
    this.label = '',
    this.errorText = '',
    this.typeKeyboard = TextInputType.text,
    this.onTap,
    this.autoFocus = false,
    this.maxLength,
    this.maxLines = 1,
  });

  final List<String> listSuggestion;
  String content;
  TextInputType typeKeyboard;
  Color? borderSelected;
  Color? textColor;
  double width;
  double height;
  String hintText;
  String errorText;
  String label;
  Function(String)? onSelected;
  Function()? onTap;
  bool autoFocus;
  int? maxLength;
  int maxLines;

  @override
  State<AppAutocompleteEditText> createState() =>
      _AppAutocompleteEditTextState();
}

class _AppAutocompleteEditTextState extends State<AppAutocompleteEditText> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return widget.listSuggestion.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          // inputFormatters: widget.textInputFormater,
          style: TextStyle(
              fontSize: 15, color: Theme.of(context).colorScheme.primary),
          key: Key(textEditingController.text),
          controller: textEditingController,
          autofocus: widget.autoFocus,
          maxLines: widget.maxLines,
          keyboardType: widget.typeKeyboard,
          maxLength: widget.maxLength,
          onTap: widget.onTap,
          cursorColor: Colors.black,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          focusNode: focusNode,
          decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.inversePrimary,
              labelText: widget.label,
              hintText: widget.hintText,
              labelStyle: TextStyle(
                color:
                    widget.textColor ?? Theme.of(context).colorScheme.primary,
              ),
              // errorText: '',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: widget.borderSelected ??
                      Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: widget.borderSelected ??
                      Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: widget.borderSelected ??
                      Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(8),
              )),
        );
      },
      onSelected: widget.onSelected,
    );
  }
}
