import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_input.dart';

class TeacherCreateClassPage extends StatelessWidget {
  TeacherCreateClassPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create class"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 400),
        child: Column(
          children: [
            CustomInput(
                controller: nameController,
                hintText: "",
                labelText: "Classroom name"),
            const SizedBox(
              height: 12,
            ),
            CustomInput(
                controller: sectionController,
                hintText: "",
                labelText: "Section"),
          ],
        ),
      ),
    );
  }
}
