import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/services/python_runner.dart';

class CodeRunnerButton extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  CodeRunnerButton({super.key, required this.codeController});

  final CodeController codeController;

  late final PythonRunner runner;

  void runCode() {}

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      size: "sm",
      label: "Run",
      onTap: runCode,
      type: "ghost",
      startIcon: Icons.play_arrow,
    );
  }
}
