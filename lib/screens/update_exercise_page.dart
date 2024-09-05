import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:app_dsi/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location.dart';

class UpdateExercisePage extends StatefulWidget {
  final String docID;

  const UpdateExercisePage({super.key, required this.docID});

  @override
  State<UpdateExercisePage> createState() => _UpdateExercisePageState();
}

class _UpdateExercisePageState extends State<UpdateExercisePage> {
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _textController = TextEditingController();
  LatLng? _selectedLocation;

  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadExercise();
  }

  Future<void> _loadExercise() async {
    final doc = await firestoreService.getExerciseDocument(
      userId: _firebaseAuth.currentUser!.uid,
      docID: widget.docID,
    );

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        _textController.text = data['type'] ?? '';
        dateTime = (data['timestamp'] as Timestamp).toDate();
        GeoPoint location = data['location'] ?? GeoPoint(0, 0);
        _selectedLocation = LatLng(location.latitude, location.longitude);
      });
    }
  }

  Future<void> _pickLocation() async {
    final LatLng? newLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SelectLocationPage(
          initialPosition: _selectedLocation ?? LatLng(0, 0),
        ),
      ),
    );

    if (newLocation != null) {
      setState(() {
        _selectedLocation = newLocation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String hours = dateTime.hour.toString().padLeft(2, '0');
    final String minutes = dateTime.minute.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Exercício'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Edite o exercício',
                hintText: 'Ex: Novo título',
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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text(
                        '${dateTime.day}/${dateTime.month}/${dateTime.year}'),
                    onPressed: () async {
                      final date = await pickDate();
                      if (date == null) return;
                      setState(() {
                        dateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          dateTime.hour,
                          dateTime.minute,
                        );
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
                      setState(() {
                        dateTime = DateTime(
                          dateTime.year,
                          dateTime.month,
                          dateTime.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text(
                      _selectedLocation != null
                          ? 'Localização: ${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}'
                          : 'Escolher Localização',
                    ),
                    onPressed: _pickLocation,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: MaterialButton(
                  onPressed: () {
                    final Timestamp timestamp = Timestamp.fromDate(dateTime);
                    firestoreService.updateExercise(
                        userId: _firebaseAuth.currentUser!.uid,
                        docID: widget.docID,
                        newType: _textController.text,
                        newTimestamp: timestamp,
                        newLocation: _selectedLocation != null
                            ? GeoPoint(
                                _selectedLocation!.latitude,
                                _selectedLocation!.longitude,
                              )
                            : null);

                    _textController.clear();
                    Navigator.pushNamed(context, '/homepage');
                  },
                  color: lightColorScheme.primary,
                  child: const Text('Salvar'),
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
