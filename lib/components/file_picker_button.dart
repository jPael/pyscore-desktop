import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/constants/custom_button_type.dart';

class FilePickerButton extends StatefulWidget {
  const FilePickerButton({
    super.key,
    required this.handleFilePick,
    this.allowedExtensions,
  });

  final Function handleFilePick;
  final List<String>? allowedExtensions;

  @override
  FilePickerButtonState createState() => FilePickerButtonState();
}

class FilePickerButtonState extends State<FilePickerButton> {
  void filePick(BuildContext context) async {
    try {
      List<PlatformFile>? files = (await FilePicker.platform.pickFiles(
        compressionQuality: 30,
        type: widget.allowedExtensions == null ? FileType.any : FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) {
          if (kDebugMode) {
            print(status);
          }
        },
        dialogTitle: "Select a file",
        allowedExtensions: widget.allowedExtensions,
        lockParentWindow: true,
      ))
          ?.files;

      if (files != null) {
        widget.handleFilePick(files[0].path!);
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Unsupported operation: $e");
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Error: $e");
        print(stackTrace);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      size: CustomButtonSize.sm,
      label: "Pick a file",
      onTap: () => filePick(context),
      type: CustomButtonType.ghost,
      startIcon: Icons.file_open_outlined,
    );
  }
}
