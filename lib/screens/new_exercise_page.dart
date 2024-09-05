import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:app_dsi/screens/maps.dart';
import 'package:app_dsi/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
 // Import the MapPicker widget

class NewExercise extends StatefulWidget {
  const NewExercise({super.key});

  @override
  State<NewExercise> createState() => _NewExerciseState();
}

class _NewExerciseState extends State<NewExercise> {
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _textController = TextEditingController();
  DateTime dateTime = DateTime.now();
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    final String hours = dateTime.hour.toString().padLeft(2, '0');
    final String minutes = dateTime.minute.toString().padLeft(2, '0');

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
                        if (date == null) return;
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
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('$hours:$minutes'),
                      onPressed: () async {
                        final time = await pickTime();
                        if (time == null) return;
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
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final location = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapPicker(
                          onLocationPicked: (location) {
                            Navigator.pop(context, location);
                          },
                        ),
                      ),
                    );
                    if (location != null) {
                      setState(() {
                        _selectedLocation = location;
                      });
                    }
                  },
                  child: Text(
                    _selectedLocation != null
                        ? 'Location: ${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}'
                        : 'Pick Location',
                  ),
                ),
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
                      timestamp: timestamp,
                      location: _selectedLocation != null
                          ? GeoPoint(
                              _selectedLocation!.latitude,
                              _selectedLocation!.longitude,
                            )
                          : null,
                    );
                    _textController.clear();
                    Navigator.pushNamed(context, '/homepage');
                  },
                  color: lightColorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                    child: Text(
                      'Adicionar',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
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
