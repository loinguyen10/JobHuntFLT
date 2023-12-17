import 'package:flutter/material.dart';

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
    this.showRemoveButton = true,
    this.readOnly = false,
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
  bool showRemoveButton;
  bool readOnly;

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
        // if (!widget.listSuggestion.any((x) => x == textEditingValue.text)) {
        //   return widget.listSuggestion.where((String option) {
        //         return option
        //             .toLowerCase()
        //             .contains(textEditingValue.text.toLowerCase());
        //       }).toList() +
        //       [textEditingValue.text];
        // }

        return widget.listSuggestion.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
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
          readOnly: widget.readOnly,
          decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.inversePrimary,
              labelText: widget.label,
              hintText: widget.hintText,
              labelStyle: TextStyle(
                color:
                    widget.textColor ?? Theme.of(context).colorScheme.primary,
              ),
              suffixIcon: widget.showRemoveButton
                  ? IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      onPressed: () {
                        setState(() {
                          textEditingController.clear();
                        });
                      },
                    )
                  : null,
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

class AppAutocompleteEditText2 extends StatefulWidget {
  AppAutocompleteEditText2({
    super.key,
    required this.listSuggestion,
    this.hintText = '',
    this.onSelected,
    this.content = '',
    this.borderSelected,
    this.textColor,
    this.width = double.infinity,
    this.height = 56,
    this.label = '',
    this.errorText = '',
    this.typeKeyboard = TextInputType.text,
    this.autoFocus = false,
    this.maxLength,
    this.maxLines = 1,
    this.showRemoveButton = true,
    this.onChanged,
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
  bool autoFocus;
  int? maxLength;
  int maxLines;
  bool showRemoveButton;
  ValueChanged? onChanged;

  @override
  State<AppAutocompleteEditText2> createState() =>
      _AppAutocompleteEditText2State();
}

class _AppAutocompleteEditText2State extends State<AppAutocompleteEditText2> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        if (!widget.listSuggestion.any((x) => x == textEditingValue.text)) {
          return widget.listSuggestion.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        }

        return widget.listSuggestion.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          // inputFormatters: widget.textInputFormater,
          style: TextStyle(
              fontSize: 15, color: Theme.of(context).colorScheme.primary),
          key: Key(textEditingController.text),
          controller: textEditingController,
          autofocus: widget.autoFocus,
          maxLines: widget.maxLines,
          keyboardType: widget.typeKeyboard,
          maxLength: widget.maxLength,
          onChanged: (value) => textEditingController.text = value,
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
              suffixIcon: widget.showRemoveButton
                  ? IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      onPressed: () {
                        setState(() {
                          textEditingController.clear();
                        });
                      },
                    )
                  : null,
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
