import 'package:flutter/material.dart';
import 'package:pyscore/components/student_signin_form.dart';
import 'package:pyscore/pages/landing_page.dart';
import 'package:pyscore/pages/student_login_page.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "{ PyScore }",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              // Navigator.pop(context);

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StudentLoginPage()));
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => const LandingScreen(),
              // ));
            },
          ),
        ],
      ),
    );
  }
}
