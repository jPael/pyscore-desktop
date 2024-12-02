import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatefulWidget {
  const CustomInput(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      this.isPassword = false,
      this.validator,
      this.minLine,
      this.maxLine = 1,
      this.enabled = true,
      this.inputType = InputType.text,
      this.formatters,
      this.length});

  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final int? minLine;
  final int? maxLine;
  final bool enabled;
  final InputType inputType;
  final List<TextInputFormatter>? formatters;
  final int? length;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool hidePassword = false;

  void handleVisibilityToggle() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  TextInputType inputType(InputType type) {
    switch (type) {
      case InputType.text:
        return TextInputType.text;
      case InputType.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: inputType(widget.inputType),
        maxLines: !widget.isPassword ? widget.maxLine : 1,
        minLines: !widget.isPassword ? widget.minLine : 1,
        obscureText: widget.isPassword && !hidePassword,
        enabled: widget.enabled,
        controller: widget.controller,
        inputFormatters: widget.formatters,
        maxLength: widget.length,
        decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            border: const OutlineInputBorder(),
            suffixIcon: widget.isPassword
                ? passwordVisibilityToggle(
                    context, hidePassword, handleVisibilityToggle)
                : null),
        validator: widget.validator);
  }

  Widget passwordVisibilityToggle(
      BuildContext context, hidePassword, handleVisibilityToggle) {
    return IconButton(
        onPressed: handleVisibilityToggle,
        icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility));
  }
}

enum InputType { text, number }
