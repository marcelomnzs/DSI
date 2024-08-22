import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create - Add a new exercise
  Future<void> addExercise({
    required String userId,
    required String type,
    required Timestamp timestamp,
    // TODO: Verificar parâmetros dos exercícios a serem cadastrados
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('exercises')
          .add({
        'type': type,
        'timestamp': timestamp,
      });
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  // Read - Get exercises from the database
  Stream<QuerySnapshot> getExerciseStream({required String userId}) {
    final exercisesStream = _firestore
        .collection('users')
        .doc(userId)
        .collection('exercises')
        .orderBy('type', descending: true)
        .snapshots();

    return exercisesStream;
  }

  // Read - Get exercises from the database
  Stream<QuerySnapshot> getFirstFiveExercisesStream({required String userId}) {
    final exercisesStream = _firestore
        .collection('users')
        .doc(userId)
        .collection('exercises')
        .limit(5)
        .orderBy('type', descending: true)
        .snapshots();

    return exercisesStream;
  }

  // Update - Update exercise given a doc id
  Future<void> updateExercise({
    required String userId,
    required String docID,
    required String newType,
    required Timestamp newTimestamp,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('exercises')
          .doc(docID)
          .update({
        'type': newType,
        'timestamp': newTimestamp,
      });
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  // Delete - Delete exercise given a doc id
  Future<void> deleteExercise({
    required String userId,
    required String docID,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('exercises')
        .doc(docID)
        .delete();
  }
}
