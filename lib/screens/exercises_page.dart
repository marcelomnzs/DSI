import 'package:app_dsi/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Exercises extends StatelessWidget {
  Exercises({super.key});

// Creating firestore instance
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          Column(
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

          const SizedBox(height: 10),

          // Grid
          Text(
            'Meus exercícios',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          Expanded(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: firestoreService.getExerciseStream(),
                  builder: (context, snapshot) {
                    // If we have data, get all the docs
                    if (snapshot.hasData) {
                      List exercisesList = snapshot.data!.docs;

                      // Display the data as a list
                      return ListView.builder(
                        itemCount: exercisesList.length,
                        itemBuilder: (context, index) {
                          // Get individual doc
                          DocumentSnapshot document = exercisesList[index];
                          String docID = document.id;

                          // Get exercise from each doc
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String exerciseType = data['type'];

                          // Display as a list tile
                          return ListTile(
                            title: Text(exerciseType.toUpperCase()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text('No notes...');
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
