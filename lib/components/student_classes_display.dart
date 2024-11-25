import 'package:flutter/material.dart';
import 'package:pyscore/mockData/classes.dart';

class StudentClassesDisplay extends StatelessWidget {
  StudentClassesDisplay({super.key, required this.handleOpenClass});

  final Function handleOpenClass;

  final classes = Classes().classData;

  void debugList(List<Map<String, dynamic>> list) {
    for (var i = 0; i < list.length; i++) {
      print('Item $i: ${list[i]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugList(classes);

    return Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Theme.of(context).colorScheme.surface,
            child: Wrap(
              children: classes.map((c) {
                final name = c["classroomName"];
                final owner = c["owner"];

                return GestureDetector(
                  onTap: () => handleOpenClass(c, context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: 350,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${name}",
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text("Teacher: $owner"),
                          ]),
                    ),
                  ),
                );
              }).toList(),
            )));
  }
}
