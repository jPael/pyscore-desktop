import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_highlight/themes/arduino-light.dart';
import 'package:highlight/languages/python.dart';
import 'package:pyscore/components/code_runner_button.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/file_picker_button.dart';
import 'package:pyscore/components/save_button.dart';
import 'package:pyscore/models/file_opener.dart';

class ActivityCodeSpace extends StatefulWidget {
  const ActivityCodeSpace(
      {super.key, required this.unlocked, required this.isDone});

  final bool unlocked;
  final bool isDone;

  @override
  ActivityCodeSpaceState createState() => ActivityCodeSpaceState();
}

class ActivityCodeSpaceState extends State<ActivityCodeSpace> {
  bool hasNotSaved = true;
  final controller = CodeController(language: python);

  String filename = "";

  final FileOpener file = FileOpener();

  void handleFilePick(String fileDirectory) async {
    file.setFileDirectory(fileDirectory);

    String fileContent = await file.readFileDataAsString();

    setState(() {
      controller.text = fileContent;
      filename = file.getFileName;
    });
  }

  void handleSave() {
    setState(() {
      hasNotSaved = false;
    });
  }

  void changesMade(String value) {
    // print(controller.text);

    setState(() {
      hasNotSaved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isDone) {
      return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(top: 3, right: 6, left: 2, bottom: 6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            width: MediaQuery.of(context).size.width / 2.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    size: 120,
                    color:
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.4),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Time is up! Your works has been automatically submitted",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ));
    } else {
      return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.only(top: 3, right: 6, left: 2, bottom: 6),
        child: !widget.unlocked
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: MediaQuery.of(context).size.width / 2.5,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_rounded,
                        size: 120,
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.4),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        "Start the timer first to start coding",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.code,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text("Code"),
                      const SizedBox(
                        width: 6,
                      ),
                      const Spacer(),
                      SaveButton(
                        hasNotSaved: hasNotSaved,
                        filename: filename,
                        handleSave: handleSave,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      FilePickerButton(handleFilePick: handleFilePick),
                      const SizedBox(
                        width: 6,
                      ),
                      CodeRunnerButton(codeController: controller),
                      const SizedBox(
                        width: 6,
                      ),
                      CustomButton(
                        size: "sm",
                        label: "Submit",
                        onTap: () {},
                        startIcon: Icons.check,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Divider(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: CodeTheme(
                        data: CodeThemeData(styles: arduinoLightTheme),
                        child: CodeField(
                            onChanged: (v) => changesMade(v),
                            gutterStyle: const GutterStyle(
                              width: 80,
                              textStyle: TextStyle(height: 1.5),
                              showLineNumbers: true,
                            ),
                            minLines: 25,
                            controller: controller)),
                  ))
                ],
              ),
      );
    }
  }
}
