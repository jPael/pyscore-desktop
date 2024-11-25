import 'package:flutter/material.dart';
import 'package:pyscore/components/loginCarousel.dart';
import 'package:pyscore/components/student_signin_form.dart';
import 'package:pyscore/components/student_signup_form.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  StudentLoginScreenState createState() => StudentLoginScreenState();
}

class StudentLoginScreenState extends State<StudentLoginScreen> {
  bool _isSignUp = false; // Track whether to show the sign-up form
  bool _isSignUpStep2 =
      false; // Track whether to show the second step of sign-up form

  void handleSwitchForm(isSignUp) {
    setState(() {
      _isSignUp = isSignUp;
    });
  }

  void handleSignupStep(isSignUpStep2) {
    setState(() {
      _isSignUpStep2 = isSignUpStep2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      // ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: const SliderP(),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: 380,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: _isSignUp
                      ? SignupForm(
                          isStep2: _isSignUpStep2,
                          handleFormSwitch: handleSwitchForm,
                          handleSignupStep: handleSignupStep)
                      : StudentSigninForm(
                          handleFormSwitch: handleSwitchForm,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
