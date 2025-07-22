import 'package:flutter/material.dart';
import 'package:quotes_poetry_flutter_app/theme/app_pallete.dart';

class TopPoetryDetail extends StatelessWidget {
  const TopPoetryDetail({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = 600.0;
    final text = AppPalette.text1;
    return Stack(
      children: [
        Positioned(
          top: -415,
          right: -100,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppPalette.gradient2,
            ),
          ),
        ),
        Positioned(
          top: 68,
          left: 112,
          child: Text(
            title.length <= 12
                ? title.toUpperCase()
                : '${title.substring(0, 11)}...'.toUpperCase(),
            style: TextStyle(fontSize: 27, color: text, fontFamily: "Farro"),
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
