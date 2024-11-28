import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';

class TeacherSignupFormStep2 extends StatefulWidget {
  const TeacherSignupFormStep2(
      {super.key,
      required this.handleFormSwitch,
      required this.handleSignupStep,
      required this.handleSignUp,
      required this.firstnameController,
      required this.lastnameController});

  final Function handleFormSwitch;
  final Function handleSignupStep;
  final Function handleSignUp;

  final TextEditingController firstnameController;
  final TextEditingController lastnameController;

  @override
  TeacherSignupFormStep2State createState() => TeacherSignupFormStep2State();
}

class TeacherSignupFormStep2State extends State<TeacherSignupFormStep2> {
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                'Create an account as teacher',
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
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "User",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomInput(
            isPassword: false,
            controller: widget.firstnameController,
            hintText: "e.g. Juan",
            labelText: "First name",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInput(
            controller: widget.lastnameController,
            hintText: "e.g. Dela Cruz",
            labelText: "Last name",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  startIcon: Icons.arrow_back_outlined,
                  label: "Back",
                  onTap: () => widget.handleSignupStep(false)),
              CustomButton(
                  endIcon: Icons.arrow_forward,
                  label: "Sign up",
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      widget.handleSignUp();
                    }
                  })
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  widget.handleSignupStep(false);
                  widget.handleFormSwitch(false);
                },
                child: Text(
                  'Sign in',
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
