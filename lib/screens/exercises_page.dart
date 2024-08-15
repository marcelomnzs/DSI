import 'package:app_dsi/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Exercises extends StatefulWidget {
  const Exercises({super.key});

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
// Creating firestore instance
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getExerciseStream(),
        builder: (context, snapshot) {
          // If we have data, get all the docs
          if (snapshot.hasData) {
            print('Tem data aqui');
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
    );
  }
}
