import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future<void> addExercise({
  required String userId,
  required String type,
  required Timestamp timestamp,
  GeoPoint? location, // Adiciona a localização como parâmetro opcional
}) async {
  try {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('exercises')
        .add({
      'type': type,
      'timestamp': timestamp,
      if (location != null) 'location': location, // Adiciona a localização ao documento, se fornecida
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

  
Future<void> updateExercise({
  required String userId,
  required String docID,
  required String newType,
  required Timestamp newTimestamp,
  GeoPoint? newLocation, // Aceitar GeoPoint? ao invés de GeoPoint
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
      if (newLocation != null) 'location': newLocation,
    });
  } on FirebaseException catch (e) {
    print(e.code);
  }
}

  // Method to get a specific exercise document
Future<DocumentSnapshot> getExerciseDocument({
  required String userId,
  required String docID,
}) {
  return _firestore
      .collection('users')
      .doc(userId)
      .collection('exercises')
      .doc(docID)
      .get();
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
