import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Get collection of exercices
  final CollectionReference exercises =
      FirebaseFirestore.instance.collection('Exercises');

  // Create - Add a new exercise
  Future<void> addExercise(String type, Timestamp timestamp) {
    return exercises.add({
      'type': type,
      'timestamp': timestamp,
    });
  }

  // Read - Get exercises from the database
  Stream<QuerySnapshot> getExerciseStream() {
    final exercisesStream =
        exercises.orderBy('type', descending: true).snapshots();

    return exercisesStream;
  }

  // Update - Update exercise given a doc id
  Future<void> updateExercise(
      String docID, String newType, Timestamp newTimestamp) {
    return exercises.doc(docID).update({
      'type': newType,
      'timestamp': newTimestamp,
    });
  }

  // Delete - Delete exercise given a doc id
  Future<void> deleteExercise(String docID) {
    return exercises.doc(docID).delete();
  }
}
