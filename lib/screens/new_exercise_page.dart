import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:app_dsi/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewExercise extends StatefulWidget {
  const NewExercise({super.key});

  @override
  State<NewExercise> createState() => _NewExerciseState();
}

class _NewExerciseState extends State<NewExercise> {
  // Firestore instance
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Controller for textInput
  final _textController = TextEditingController();

  // Date and Time picker utils
  DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  @override
  Widget build(BuildContext context) {
    final String hours = dateTime.hour.toString().padLeft(2, '0');
    final String minutes = dateTime.hour.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Exercício'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Adicione um exercício',
                hintText: 'Ex: Caminhada',
                suffix: IconButton(
                  onPressed: () {
                    _textController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
                labelStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                          '${dateTime.day}/${dateTime.month}/${dateTime.year}'),
                      onPressed: () async {
                        final date = await pickDate();
                        // If user pressed "CANCEL"
                        if (date == null) return;

                        // Pressed 'OK'
                        final selectedDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          dateTime.hour,
                          dateTime.minute,
                        );

                        setState(() {
                          dateTime = selectedDateTime;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 80),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('$hours:$minutes'),
                      onPressed: () async {
                        final time = await pickTime();
                        // If user pressed "CANCEL"
                        if (time == null) return;
                        // Pressed 'OK'
                        final selectedDateTime = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            time.hour,
                            time.minute);

                        setState(() {
                          dateTime = selectedDateTime;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: MaterialButton(
                  onPressed: () async {
                    final Timestamp timestamp = Timestamp.fromDate(dateTime);
                    await firestoreService.addExercise(
                        userId: _firebaseAuth.currentUser!.uid,
                        type: _textController.text,
                        timestamp: timestamp);
                    // UI improvent
                    _textController.clear();
                    // Return to all exercises
                    Navigator.pushNamed(context, '/homepage');
                  },
                  color: lightColorScheme.primary,
                  child: const Text('Adicionar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        lastDate: DateTime(2100),
        firstDate: dateTime,
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );
}
