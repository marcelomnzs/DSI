import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Get collection of exercices
  final CollectionReference exercises =
      FirebaseFirestore.instance.collection('Exercises');

  // Create - Add a new exercise

  // Read - Get exercises from the database
  Stream<QuerySnapshot> getExerciseStream() {
    final exercisesStream =
        exercises.orderBy('date', descending: false).snapshots();

    return exercisesStream;
  }
  // Update - Update exercise given a doc id

  // Delete - Delete exercise given a doc id
}
