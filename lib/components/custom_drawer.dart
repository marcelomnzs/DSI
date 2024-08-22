import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:app_dsi/services/autenticacao.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final AutenticacaoServico autenticacao = AutenticacaoServico();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: lightColorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.favorite,
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: const Text('Adicionar exercício'),
                  onTap: () {
                    Navigator.pushNamed(context, '/newexercise');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.view_list),
                  title: const Text('Ver todos os Exercícios'),
                  onTap: () {
                    Navigator.pushNamed(context, '/exercises');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.medication),
                  title: const Text('Adicionar suplemento/remédio'),
                  onTap: () {
                    Navigator.pushNamed(context, '/suplemento');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Meu perfil'),
                  onTap: () {
                    Navigator.pushNamed(context, '');
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmar Logout'),
                      content:
                          const Text('Você tem certeza de que deseja sair?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await autenticacao.deslogarUsuario();
                          },
                          child: const Text('Sair'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
