import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeRunnerConsole extends StatelessWidget {
  const CodeRunnerConsole({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(top: 3, bottom: 6, left: 6, right: 2),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Console"),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 200, maxHeight: 200),
            child: ListView(
              children: [
                logText(context),
                logText(context),
                logText(context),
                logText(context),
                logText(context),
                logText(context),
                logText(context),
                logText(context),
                logText(context),
                logText(context),
                logText(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget logText(BuildContext context) {
    TextStyle consoleFont =
        GoogleFonts.getFont("Source Code Pro", fontSize: 12);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "=>",
          style: consoleFont,
        ),
        const SizedBox(
          width: 3,
        ),
        Expanded(
          child: Text(
            "{\"cmd\":10,\"path\":\"C:/Program Files/Tesseract-OCR/tesseract.exe\"}",
            style: consoleFont,
          ),
        ),
      ],
    );
  }
}
