import 'package:flutter/material.dart';
import 'package:pyscore/components/student_signup_form_step1.dart';
import 'package:pyscore/components/student_signup_form_step2.dart';

class SignupForm extends StatefulWidget {
  const SignupForm(
      {super.key,
      required this.isStep2,
      required this.handleFormSwitch,
      required this.handleSignupStep});

  final Function handleFormSwitch;
  final Function handleSignupStep;
  final bool isStep2;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController schoolIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();

  void handleSignUp() async {
    print(schoolIdController.text);
    print(passwordController.text);
    print(firstnameController.text);
    print(lastnameController.text);
    print(sectionController.text);

    widget.handleFormSwitch(false);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isStep2
        ? StudentSignupFormStep2(
            handleFormSwitch: widget.handleFormSwitch,
            handleSignupStep: widget.handleSignupStep,
            firstnameController: firstnameController,
            lastnameController: lastnameController,
            sectionController: sectionController,
            handleSignUp: handleSignUp)
        : StudentSignupFormStep1(
            handleFormSwitch: widget.handleFormSwitch,
            handleSignupStep: widget.handleSignupStep,
            schoolIdController: schoolIdController,
            passwordController: passwordController,
            confirmPaswordController: confirmPasswordController,
          );
  }
}
