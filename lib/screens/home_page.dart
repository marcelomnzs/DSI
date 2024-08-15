import 'package:flutter/material.dart';

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
                child: const Text('Voltar'),
                onPressed: () {
                  Navigator.pushNamed(context, '/loginpage');
                },
              ),
            ],
          ),
        ));
  }
}
