import 'package:flutter/material.dart';
import 'package:pyscore/components/activity_code_space.dart';
import 'package:pyscore/components/activity_instructions_panel.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/pages/code_runner_console.dart';

class StudentActivityPage extends StatefulWidget {
  const StudentActivityPage({super.key, required this.post});

  final Posts post;

  @override
  State<StudentActivityPage> createState() => _StudentActivityPageState();
}

class _StudentActivityPageState extends State<StudentActivityPage> {
  bool unlocked = false;
  bool isDone = false;

  void handleActivityUnlock() {
    setState(() {
      unlocked = true;
    });
  }

  void handleActivityFinish() {
    setState(() {
      isDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity "),
        forceMaterialTransparency: true,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.2,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ActivityInstructionsPanel(
                    post: widget.post,
                    unlocked: unlocked,
                    handleUnlock: handleActivityUnlock,
                    handleActivityFinish: handleActivityFinish,
                    isDone: isDone,
                  ),
                  const CodeRunnerConsole()
                ],
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Expanded(
                child: ActivityCodeSpace(
              unlocked: unlocked,
              isDone: isDone,
            ))
          ],
        ),
      ),
    );
  }
}
