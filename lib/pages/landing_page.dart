import 'package:flutter/material.dart';
import 'package:pyscore/pages/teacher_login_page.dart';
import 'package:pyscore/pages/student_login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("{",
                    style: GoogleFonts.getFont('Montserrat',
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 120)),
                Text(" PyScore ",
                    style: GoogleFonts.getFont('Montserrat',
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 120,
                        fontWeight: FontWeight.bold)),
                Text("}",
                    style: GoogleFonts.getFont('Montserrat',
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 120)),
              ],
            ),
            Text(
              "Northeastern Mindanao State University",
              style: GoogleFonts.getFont('Montserrat',
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 28),
            ),
            const SizedBox(
              height: 88,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 42)),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StudentLoginScreen())),
                child: Text(
                  "Student",
                  style: GoogleFonts.getFont('Montserrat',
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 42)),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage())),
                child: Text(
                  "Teacher",
                  style: GoogleFonts.getFont('Montserrat',
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                )),
          ],
        ),
      ),
    );
  }
}
