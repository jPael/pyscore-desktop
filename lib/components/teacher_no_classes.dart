import 'package:flutter/material.dart';
import 'package:pyscore/components/create_class_button.dart';

class TeacherNoClasses extends StatefulWidget {
  const TeacherNoClasses({super.key});

  @override
  State<TeacherNoClasses> createState() => _TeacherNoClassesState();
}

class _TeacherNoClassesState extends State<TeacherNoClasses> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "You have no class",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              const CreateClassButton(),
            ],
          ),
        ),
      ),
    );
  }
}
