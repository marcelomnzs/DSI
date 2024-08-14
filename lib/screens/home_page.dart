import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:app_dsi/screens/new_exercise_page.dart';
import 'package:app_dsi/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:app_dsi/screens/exercises_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of pages for the bottomNavBar
  final List<Widget> _pages = [
    Exercises(),
    const NewExercise(),
    const Profile()
  ];

  // Index for bottomNavBar
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: lightColorScheme.onSurface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: lightColorScheme.onSurface,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: lightColorScheme.primary,
            gap: 8,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Início',
              ),
              GButton(
                icon: Icons.add,
                text: 'Novo exercício',
              ),
              GButton(
                icon: Icons.person,
                text: 'Meu Perfil',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
