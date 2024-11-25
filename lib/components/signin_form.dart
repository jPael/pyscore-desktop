import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/instructor_navigation_bar.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({
    super.key,
    required this.handleFormSwitch,
  });

  final Function handleFormSwitch;
  @override
  SigninFormState createState() => SigninFormState();
}

class SigninFormState extends State<SigninForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sign in to PyScore',
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter School ID',
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
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            label: 'Sign inasdsad',
            onTap: () {
              if (formKey.currentState!.validate()) {
                // Perform login action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Instrucnavigationbar(),
                  ),
                );
              }
            },
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
              InkWell(
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
