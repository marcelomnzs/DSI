import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:app_dsi/firebase_options.dart';
import 'package:app_dsi/screens/RegisterPage.dart';
import 'package:app_dsi/screens/exercises_page.dart';
import 'package:app_dsi/screens/home_page.dart';
import 'package:app_dsi/screens/login_page.dart';
import 'package:app_dsi/screens/new_exercise_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/homepage': (context) => const HomePage(),
        '/registerpage': (context) => RegisterPage(),
        '/loginpage': (context) => LoginPage(),
        '/exercises': (context) => const Exercises(),
        '/newexercise': (context) => const NewExercise(),
      },
    );
  }
}
