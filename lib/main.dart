import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:app_dsi/screens/RegisterPage.dart';
import 'package:app_dsi/screens/home_page.dart';
import 'package:app_dsi/screens/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        '/': (context) =>  LoginPage(),
        '/homepage': (context) => const HomePage(),
        '/registerpage': (context) => RegisterPage(),
      },
    );
  }
}
