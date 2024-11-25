import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/pages/teacher_home_page.dart';

class TeacherSigninForm extends StatefulWidget {
  const TeacherSigninForm({super.key, required this.handleFormSwitch});

  final Function handleFormSwitch;

  @override
  TeacherSigninFormState createState() => TeacherSigninFormState();
}

class TeacherSigninFormState extends State<TeacherSigninForm> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                'Log in as teacher',
                style: GoogleFonts.getFont(
                  'Poppins',
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close))
            ],
          ),
          const SizedBox(height: 40),
          CustomInput(
            controller: usernameController,
            hintText: "",
            labelText: "Username",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeacherHomePage(),
                      ),
                    );
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
                "Don't have an account?",
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
