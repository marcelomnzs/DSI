import 'package:flutter/material.dart';

class CustomRoundedIconButton extends StatelessWidget {
  final String imagePath;
  const CustomRoundedIconButton({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(2, 2),
          ),
          const BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -2),
              blurRadius: 15,
              spreadRadius: 0.3),
        ],
      ),
      child: Image.asset(
        imagePath,
        height: 25,
      ),
    );
  }
}
