import 'package:app_dsi/core/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseCard_HomePage extends StatelessWidget {
  final String name;
  final int duration;
  final DateTime date;
  final Icon icon;

  const ExerciseCard_HomePage({
    super.key,
    required this.name,
    required this.duration,
    required this.date,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 8.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: lightColorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            leading: Container(
              padding: const EdgeInsets.only(right: 12.0),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1.0,
                    color: Colors.white24,
                  ),
                ),
              ),
              child: icon,
            ),
            title: Text(
              name,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '$duration minutes',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
