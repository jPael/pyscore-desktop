import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/components/connection_status.dart';
import 'package:pyscore/components/custom_button.dart';
import 'package:pyscore/constants/types/custom_button_type.dart';
import 'package:pyscore/pages/import_db_page.dart';
import 'package:pyscore/pages/student_login_page.dart';
import 'package:pyscore/pages/teacher_login_page.dart';
import 'package:pyscore/services/host_connection.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: const [
          ConnectionStatus(),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.import_contacts),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const ImportDbPage()))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("{",
                    style: GoogleFonts.getFont('Montserrat',
                        color: Theme.of(context).colorScheme.inversePrimary, fontSize: 8 * 12)),
                Text(" PyScore ",
                    style: GoogleFonts.getFont('Montserrat',
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 8 * 12,
                        fontWeight: FontWeight.bold)),
                Text("}",
                    style: GoogleFonts.getFont('Montserrat',
                        color: Theme.of(context).colorScheme.inversePrimary, fontSize: 8 * 12)),
              ],
            ),
            Text(
              "Northeastern Mindanao State University",
              style: GoogleFonts.getFont('Montserrat',
                  color: Theme.of(context).colorScheme.inversePrimary, fontSize: 8 * 4),
            ),
            const SizedBox(
              height: 88,
            ),
            Consumer<HostConnection>(
              builder: (context, host, child) {
                bool isConnected = host.isConnected;

                return Badge(
                  isLabelVisible: !isConnected,
                  backgroundColor: Colors.transparent,
                  label: const Icon(Icons.info, color: Colors.red),
                  child: CustomButton(
                      toolTip: !isConnected
                          ? "You are not connected to any host. Connect to the host first by click the status button on the top right corner"
                          : null,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 42),
                      size: CustomButtonSize.lg,
                      label: "Student",
                      isDisabled: !isConnected,
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const StudentLoginPage()))),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 42),
                size: CustomButtonSize.lg,
                label: "Teacher",
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const TeacherLoginPage()))),
          ],
        ),
      ),
    );
  }
}
