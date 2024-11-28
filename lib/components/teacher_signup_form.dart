import 'package:flutter/material.dart';
import 'package:pyscore/components/teacher_signup_form_step1.dart';
import 'package:pyscore/components/teacher_signup_form_step2.dart';
import 'package:pyscore/models/user.dart';

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
  TeacherSignupFormState createState() => TeacherSignupFormState();
}

class TeacherSignupFormState extends State<TeacherSignupForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  void handleSignUp() async {
    String username = usernameController.text;
    String password = passwordController.text;
    String firstname = firstnameController.text;
    String lastname = lastnameController.text;

    User user = User(
        username: username,
        password: password,
        firstname: firstname,
        lastname: lastname,
        studentId: username,
        userType: UserType.teacher);

    await user.insertToDb();

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
