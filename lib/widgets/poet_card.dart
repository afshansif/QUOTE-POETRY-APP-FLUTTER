import 'package:flutter/material.dart';
import 'package:quotes_poetry_flutter_app/theme/app_pallete.dart';

class PoetCard extends StatelessWidget {
  final String poetName;
  final Gradient gradient;

  const PoetCard({super.key, required this.poetName, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            poetName,
            style: const TextStyle(
              color: AppPalette.text1,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
