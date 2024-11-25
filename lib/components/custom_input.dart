import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  const CustomInput(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      this.isPassword = false,
      this.validator,
      this.minLine,
      this.maxLine});

  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final int? minLine;
  final int? maxLine;

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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: !widget.isPassword ? widget.maxLine : 1,
        minLines: !widget.isPassword ? widget.minLine : null,
        obscureText: widget.isPassword && !hidePassword,
        controller: widget.controller,
        decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText.isEmpty ? "" : widget.hintText,
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
