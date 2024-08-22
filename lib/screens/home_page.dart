// lib/screens/home_page.dart
import 'dart:ui';

import 'package:app_dsi/components/custom_drawer.dart';
import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:app_dsi/services/autenticacao.dart';
import 'package:app_dsi/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AutenticacaoServico autenticacao = AutenticacaoServico();
  String? name = FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Olá!',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Text(
              'Bem-vindo de volta',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Ação ao clicar no ícone de alerta
              },
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Minhas Atividades',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    )),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/exercises'),
                  child: Text(
                    'Ver todas >',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(color: Colors.black26),
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestoreService.getFirstFiveExercisesStream(
                userId: _firebaseAuth.currentUser!.uid),
            builder: (context, snapshot) {
              // If we have data, get the docs
              if (snapshot.hasData) {
                List exerciseList = snapshot.data!.docs;
                // Display the data as a horizontal list
                return SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: exerciseList.length,
                        itemBuilder: (context, index) {
                          // Get each individual doc
                          DocumentSnapshot document = exerciseList[index];

                          // Get the exercise from each doc
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String exercise = data['type'];

                          return Container(
                            decoration: BoxDecoration(
                              color: lightColorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 10,
                            width: 220,
                            child: Center(
                              child: Text(
                                exercise,
                                style: TextStyle(
                                  color: lightColorScheme.onPrimary,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return const Text('Você não possui exercícios!');
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Métricas do Usuário',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Text('Ver todas >',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.black26,
                      ),
                    )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MetricItem(label: 'Atividades\ncompletadas', value: '12'),
              MetricItem(label: 'Em progresso', value: '12 Exercícios'),
              MetricItem(label: 'Tempo gasto', value: '48 Minutos'),
            ],
          ),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}

class MetricItem extends StatelessWidget {
  final String label;
  final String value;

  const MetricItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(),
        ),
      ],
    );
  }
}
