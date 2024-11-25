import 'package:flutter/material.dart';
import 'package:pyscore/components/teacher_signup_form_step1.dart';
import 'package:pyscore/components/teacher_signup_form_step2.dart';

class TeacherSignupForm extends StatefulWidget {
  const TeacherSignupForm(
      {super.key,
      required this.handleFormSwitch,
      required this.handleSignupStep,
      required this.isStep2});

  final Function handleFormSwitch;
  final Function handleSignupStep;
  final bool isStep2;

  @override
  _TeacherSignupFormState createState() => _TeacherSignupFormState();
}

class _TeacherSignupFormState extends State<TeacherSignupForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();

  void handleSignUp() async {
    print(usernameController.text);
    print(passwordController.text);
    print(firstnameController.text);
    print(lastnameController.text);
    print(sectionController.text);

    widget.handleFormSwitch(false);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isStep2
        ? TeacherSignupFormStep2(
            handleFormSwitch: widget.handleFormSwitch,
            handleSignupStep: widget.handleSignupStep,
            firstnameController: firstnameController,
            lastnameController: lastnameController,
            sectionController: sectionController,
            handleSignUp: handleSignUp)
        : TeacherSignupFormStep1(
            handleFormSwitch: widget.handleFormSwitch,
            handleSignupStep: widget.handleSignupStep,
            usernameController: usernameController,
            passwordController: passwordController,
            confirmPaswordController: confirmPasswordController,
          );
  }
}
