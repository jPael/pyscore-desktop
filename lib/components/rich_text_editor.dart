import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class RichTextEditor extends StatelessWidget {
  const RichTextEditor({super.key, required this.controller});

  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuillSimpleToolbar(
            controller: controller,
            configurations: const QuillSimpleToolbarConfigurations()),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: QuillEditor(
            scrollController: ScrollController(),
            focusNode: FocusNode(),
            controller: controller,
            configurations: QuillEditorConfigurations(
              minHeight: 300,
            ),
          ),
        )
      ],
    );
  }
}
