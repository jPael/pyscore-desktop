import 'package:flutter/material.dart';
import 'package:pyscore/components/activity_timer.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/done_chip.dart';
import 'package:pyscore/components/unfinished_chip.dart';
import 'package:pyscore/models/posts.dart';

class ActivityInstructionsPanel extends StatefulWidget {
  const ActivityInstructionsPanel(
      {super.key,
      required this.post,
      required this.unlocked,
      required this.handleUnlock,
      required this.isDone,
      required this.handleActivityFinish});

  final Posts post;
  final bool unlocked;
  final VoidCallback handleUnlock;
  final bool isDone;
  final Function handleActivityFinish;

  @override
  ActivityInstructionsPanelState createState() =>
      ActivityInstructionsPanelState();
}

class ActivityInstructionsPanelState extends State<ActivityInstructionsPanel> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 3, bottom: 3, left: 6, right: 3),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: !widget.unlocked
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "The contents are hidden since you haven't started the timer yet",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomButton(label: "Start", onTap: widget.handleUnlock)
                    ],
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActivityTimer(
                    handleActivityFinish: widget.handleActivityFinish,
                    points: widget.post.points.toString(),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.post.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      widget.isDone ? const DoneChip() : const UnfinishedChip(),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(widget.post.instructions),
                ],
              ),
      ),
    );
  }
}
