import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/constants/auth_errors.dart';
import 'package:pyscore/constants/user_type.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:pyscore/pages/student_home_page.dart';
import 'package:pyscore/services/auth.dart' as auth;
import 'package:provider/provider.dart';
import 'package:pyscore/utils/results.dart';

class StudentSigninForm extends StatefulWidget {
  const StudentSigninForm({super.key, required this.handleFormSwitch});

  final Function handleFormSwitch;

  @override
  StudentSigninFormState createState() => StudentSigninFormState();
}

class StudentSigninFormState extends State<StudentSigninForm> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? error;

  @override
  void dispose() {
    studentIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleSignin(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final String studentId = studentIdController.text;
    final String password = passwordController.text;

    final AuthResults res = await auth.signIn(studentId, password, UserType.student);

    if (!res.isSuccess) {
      setState(() {
        error = Autherrors.error(res.error!);
      });

      return;
    }

    if (!context.mounted) {
      return;
    }
    context.read<MyClassrooms>().initUser(res.user.id!, res.user.userType);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => StudentHomePage(user: res.user)));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Log in as student',
                style: GoogleFonts.getFont(
                  'Poppins',
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))
            ],
          ),
          const SizedBox(height: 40),
          if (error != null)
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.redAccent.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      error ?? "",
                      softWrap: true,
                      style: TextStyle(color: Colors.red[900]),
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 10),
          CustomInput(
            controller: studentIdController,
            hintText: "",
            labelText: "School ID",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your School ID';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInput(
            controller: passwordController,
            hintText: "",
            labelText: "Password",
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                label: 'Sign in',
                endIcon: Icons.arrow_right_alt,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    // Perform login action
                    handleSignin(context);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => widget.handleFormSwitch(true));
                },
                child: Text(
                  'Sign up',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF102DF1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
