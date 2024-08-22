// lib/screens/home_page.dart
import 'package:app_dsi/services/autenticacao.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AutenticacaoServico autenticacao = AutenticacaoServico();
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
                onPressed: () async {
                  await autenticacao.deslogarUsuario();
                },
                child: const Text('Sair')),
          ],
        ),
      ),
    );
  }
}
