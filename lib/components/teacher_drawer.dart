import 'package:flutter/material.dart';
import 'package:pyscore/pages/landing_page.dart';

class TeacherDrawer extends StatelessWidget {
  const TeacherDrawer({super.key});

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
          // ListTile(
          //   leading: const Icon(Icons.school),
          //   title: const Text('Enrolled Classes'),
          //   onTap: () {
          //     Navigator.pop(context);

          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => const Enrolledclasses(),
          //     ));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.archive),
          //   title: const Text('Archiveds Classes'),
          //   onTap: () {
          //     Navigator.pop(context);

          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => const Archivedclasses(),
          //     ));
          //   },
          // ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LandingScreen(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
