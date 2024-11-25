import 'package:flutter/material.dart';
import 'package:pyscore/teacher/pages/archived_classes.dart';
import 'package:pyscore/teacher/pages/handled_classes.dart';

class Instrucnavigationbar extends StatelessWidget {
  const Instrucnavigationbar({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Handled Classes',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const Navigation(),
        body: const Text("bitch"),
      );
}

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildHeader(context),
                buildMenuItems(context),
              ]),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );

  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Handled Classes'),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Handledclasses(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.archive),
            title: const Text('Archived Classes'),
            onTap: () {
              Navigator.pop(context);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Archivedclasses(),
              ));
            },
          ),
        ],
      );
}
