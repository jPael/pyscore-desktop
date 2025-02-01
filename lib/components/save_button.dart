import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/progress_unsaved_indicator.dart';
import 'package:pyscore/constants/types/custom_button_type.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:uuid/uuid.dart';

class SaveButton extends StatefulWidget {
  const SaveButton(
      {super.key,
      required this.hasNotSaved,
      required this.filename,
      required this.setSaveState,
      required this.content});

  final String content;
  final bool hasNotSaved;
  final String filename;
  final Function setSaveState;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  Future<void> handleSave() async {
    // final Uuid uuid = Uuid();

    // final String currentDateTime = DateTime.now().toString();
    // final String userId = context.read<MyClassrooms>().userId!;
    // final String filename = uuid.v4();
    // final String filenameExtension = ".py";

    // final fullFilename = "$currentDateTime-$userId-$filename$filenameExtension";

    widget.setSaveState(true);
  }

  @override
  Widget build(BuildContext context) {
    final saveStatusText = widget.hasNotSaved ? "Unsaved" : "Saved";

    return CustomButton(
      startWidget: ProgressUnsavedIndicator(hasNotSaved: widget.hasNotSaved),
      label: saveStatusText,
      type: CustomButtonType.ghost,
      onTap: () async => handleSave(),
    );
  }
}
