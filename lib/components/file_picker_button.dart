import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pyscore/components/custom_button.dart';

class FilePickerButton extends StatefulWidget {
  const FilePickerButton({
    super.key,
    required this.handleFilePick,
  });

  final Function handleFilePick;

  @override
  _FilePickerButtonState createState() => _FilePickerButtonState();
}

class _FilePickerButtonState extends State<FilePickerButton> {
  Future<String?> getDesktopDirectory() async {
    if (Platform.isWindows) {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      final String desktopPath = '${appDocumentsDir.parent.path}\\Desktop';
      return desktopPath;
    }
    return null; // Return null if not Windows or path unavailable
  }

  void filePick(BuildContext context) async {
    final String? appDocumentsDir = await getDesktopDirectory();

    final Directory rootPath = Directory(appDocumentsDir!);

    String? path;

    if (context.mounted) {
      path = await FilesystemPicker.open(
        title: 'Open file',
        context: context,
        rootDirectory: rootPath,
        fsType: FilesystemType.file,
        allowedExtensions: ['.py'],
        fileTileSelectMode: FileTileSelectMode.wholeTile,
      );

      widget.handleFilePick(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      size: "sm",
      label: "Pick a file",
      onTap: () => filePick(context),
      type: "ghost",
      startIcon: Icons.file_open_outlined,
    );
  }
}
