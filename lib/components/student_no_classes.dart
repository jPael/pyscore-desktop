import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';

class StudentNoClasses extends StatelessWidget {
  StudentNoClasses({super.key});

  final TextEditingController classCodeController = TextEditingController();

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
              SizedBox(
                width: 250,
                child: CustomInput(
                    controller: classCodeController,
                    hintText: "",
                    labelText: "Enter a class code to join"),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(label: "Join", onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
