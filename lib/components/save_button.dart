import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/progress_unsaved_indicator.dart';

class SaveButton extends StatelessWidget {
  const SaveButton(
      {super.key,
      required this.hasNotSaved,
      required this.filename,
      required this.handleSave});

  final bool hasNotSaved;
  final String filename;
  final VoidCallback handleSave;

  @override
  Widget build(BuildContext context) {
    final saveStatusText = hasNotSaved ? "Unsaved" : "Saved";

    return CustomButton(
      startWidget: ProgressUnsavedIndicator(hasNotSaved: hasNotSaved),
      label: saveStatusText,
      onTap: handleSave,
      type: "ghost",
    );
  }
}
