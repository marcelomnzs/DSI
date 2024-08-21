// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:app_dsi/screens/splash.dart'; // Certifique-se de que o caminho está correto

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Ir para a página de exercícios'),
              onPressed: () {
                Navigator.pushNamed(context, '/exercises');
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Adicionar novo exercício'),
              onPressed: () {
                Navigator.pushNamed(context, '/newexercise');
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Adicionar suplemento'),
              onPressed: () {
                Navigator.pushNamed(context, '/suplemento');
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Voltar'),
              onPressed: () {
                // Navega para a tela de splash antes de ir para a página de login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Splash(nextRoute: '/loginpage'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
