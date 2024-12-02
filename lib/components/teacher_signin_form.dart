import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/components/custom_input.dart';
import 'package:pyscore/constants/auth_errors.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:pyscore/pages/teacher_home_page.dart';
import 'package:pyscore/services/auth.dart';
import 'package:pyscore/utils/results.dart';
import 'package:provider/provider.dart';

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

  String? error;

  void handleSignin(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final Auth auth = Auth(
        username: usernameController.text, password: passwordController.text);

    final AuthResults res = await auth.signIn();

    if (!res.isSuccess) {
      setState(() {
        error = Autherrors.error(res.error!);
      });

      return;
    }

    if (!context.mounted) {
      return;
    }

    context.read<MyClassrooms>().setId(res.user.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeacherHomePage(user: res.user),
      ),
    );
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
          if (error != null)
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.3),
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
                  handleSignin(context);
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
