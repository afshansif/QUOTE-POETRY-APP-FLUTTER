import 'package:flutter/material.dart';
import 'package:quotes_poetry_flutter_app/theme/app_pallete.dart';
import 'package:quotes_poetry_flutter_app/widgets/circular_container.dart';

class TopGhazalScreen extends StatelessWidget {
  const TopGhazalScreen({super.key, required this.title, required this.favGhazal});
  final String title;
  final VoidCallback favGhazal;

  @override
  Widget build(BuildContext context) {
    final color = AppPalette.container2;
    final size = 600.0;
    final text = AppPalette.text1;
    return Stack(
      children: [
        Positioned(
          top: -415,
          right: -100,
          child: CircularContainer(color: color, size: size),
        ),
        Positioned(
          top: 65,
          left: 120,
          child: Text(
            title,
            style: TextStyle(fontFamily: 'Farro', fontSize: 24),
          ),
        ),
        Positioned(
          top: 60,
          left: 20,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp, color: text),
          ),
        ),
       
      ],
    );
  }
}
