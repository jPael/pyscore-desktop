import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/file_picker_button.dart';
import 'package:pyscore/services/db.dart';

class ImportDbPage extends StatefulWidget {
  const ImportDbPage({super.key});

  @override
  ImportDbPageState createState() => ImportDbPageState();
}

class ImportDbPageState extends State<ImportDbPage> {
  bool _dragging = false;

  String? _fileDirectory;

  void handleFilePick(String fileDirectory) async {
    setState(() {
      _fileDirectory = fileDirectory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Import Database"),
      ),
      body: DropTarget(
          onDragDone: (detail) {
            print("printing: " + detail.files[0].path);
            setState(() {
              _fileDirectory = detail.files[0].path;
            });
          },
          onDragEntered: (detail) {
            setState(() {
              _dragging = true;
            });
          },
          onDragExited: (detail) {
            setState(() {
              _dragging = false;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 200,
                color: _dragging ? Colors.blue.withValues(alpha: 0.4) : Colors.black26,
                child: Text(_fileDirectory ?? "Drop your database file here"),
              ),
              Row(
                children: [
                  FilePickerButton(
                    handleFilePick: handleFilePick,
                  ),
                  CustomButton(label: "Update", onTap: () => Db.instance.replaceDb(_fileDirectory)),
                  CustomButton(
                      label: "Clear",
                      onTap: () {
                        setState(() {
                          _fileDirectory = null;
                        });
                      }),
                  CustomButton(label: "Download db", onTap: () => Db.instance.downloadDb())
                ],
              )
            ],
          )),
    );
  }
}
