import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyscore/models/my_classrooms.dart';
import 'package:pyscore/pages/landing_page.dart';
import 'package:pyscore/services/db.dart';
import 'package:pyscore/theme/theme_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await Db.instance.initDb();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => MyClassrooms())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Login & Signup',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const LandingScreen(),
    );
  }
}
