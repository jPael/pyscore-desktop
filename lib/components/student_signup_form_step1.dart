import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';

class StudentSignupFormStep1 extends StatefulWidget {
  const StudentSignupFormStep1({
    super.key,
    required this.handleFormSwitch,
    required this.handleSignupStep,
    required this.schoolIdController,
    required this.passwordController,
    required this.confirmPaswordController,
  });

  final TextEditingController schoolIdController;
  final TextEditingController passwordController;
  final TextEditingController confirmPaswordController;
  final Function handleFormSwitch;
  final Function handleSignupStep;

  @override
  State<StudentSignupFormStep1> createState() => _StudentSignupFormStep1State();
}

class _StudentSignupFormStep1State extends State<StudentSignupFormStep1> {
  String userType = 'Student'; // Default user type
  final formKey = GlobalKey<FormState>(); // Form key for validation

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
                'Create an account as student',
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
                "Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          // DropdownButtonFormField<String>(
          //   value: userType,
          //   decoration: const InputDecoration(
          //     labelText: 'Select User Type',
          //     border: OutlineInputBorder(),
          //   ),
          //   items: ['Student', 'Teacher'].map((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          //   onChanged: (newValue) {
          //     setState(() {
          //       userType = newValue!;
          //     });
          //   },
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please select a user type';
          //     }
          //     return null;
          //   },
          // ),

          const SizedBox(height: 20),
          TextFormField(
            controller: widget.schoolIdController,
            decoration: const InputDecoration(
              labelText: 'School ID',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your School ID';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInput(
            isPassword: true,
            controller: widget.passwordController,
            hintText: "",
            labelText: "Password",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),
          CustomInput(
            isPassword: true,
            controller: widget.confirmPaswordController,
            hintText: "",
            labelText: "Confirm Password",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != widget.passwordController.text) {
                return 'Passwords do not match';
              }

              return null;
            },
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    widget.handleSignupStep(true);
                  }
                },
                endIcon: Icons.arrow_forward,
                label: "Next",
              ),
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
                onTap: () => widget.handleFormSwitch(false),
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
