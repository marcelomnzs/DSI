import 'package:app_dsi/components/ExerciseCard_HomePage.dart';
import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of exercises
  List myExercises = [
    [
      'Caminhada',
      40,
      DateTime.now(),
      const Icon(
        Icons.directions_run,
        size: 45,
        color: Colors.white,
      )
    ],
    [
      'Caiaque',
      120,
      DateTime.now(),
      const Icon(
        Icons.kayaking,
        size: 45,
        color: Colors.white,
      )
    ],
    [
      'Academia',
      60,
      DateTime.now(),
      const Icon(
        Icons.fitness_center,
        size: 45,
        color: Colors.white,
      )
    ],
    [
      'Futebol',
      90,
      DateTime.now(),
      const Icon(
        Icons.sports_soccer,
        size: 45,
        color: Colors.white,
      )
    ],
    [
      'Surf',
      130,
      DateTime.now(),
      const Icon(
        Icons.surfing,
        size: 45,
        color: Colors.white,
      )
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Custom appBar
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    size: 35,
                  ),
                  Icon(
                    Icons.person,
                    size: 35,
                  )
                ],
              ),
            ),

            // Welcome home User
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bem vindo de Volta,',
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    'Fulano!',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Meus compromissos',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
            ),

            Expanded(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: myExercises.length,
                  padding: const EdgeInsets.all(25),
                  itemBuilder: (context, index) {
                    return ExerciseCard_HomePage(
                      name: myExercises[index][0],
                      duration: myExercises[index][1],
                      date: myExercises[index][2],
                      icon: myExercises[index][3],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: lightColorScheme.onBackground,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: lightColorScheme.onBackground,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(174, 184, 29, 37),
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
                icon: Icons.fitness_center,
                text: 'Meus exercícios',
              ),
              GButton(
                icon: Icons.person,
                text: 'Meu Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
