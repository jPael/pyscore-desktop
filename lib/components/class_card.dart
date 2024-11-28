import 'package:flutter/material.dart';
import 'package:pyscore/models/classroom.dart';

class ClassCard extends StatefulWidget {
  const ClassCard(
      {super.key, required this.classroom, required this.handleOpenClass});

  final Classroom classroom;
  final Function handleOpenClass;

  @override
  ClassCardState createState() => ClassCardState();
}

class ClassCardState extends State<ClassCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final name = widget.classroom.classroomName;
    final owner = widget.classroom.owner;

    return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() {
              isHovered = true;
            }),
        onExit: (_) => setState(() {
              isHovered = false;
            }),
        child: GestureDetector(
          onTap: () => widget.handleOpenClass(widget.classroom, context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 250),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                padding: const EdgeInsets.all(8),
                width: 350,
                decoration: BoxDecoration(
                    boxShadow: [
                      if (isHovered)
                        BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(2, 2))
                    ],
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              softWrap: true,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                      Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.4)),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Owner: $owner",
                            softWrap: true,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500),
                          )),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
