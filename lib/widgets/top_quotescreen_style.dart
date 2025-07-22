import 'package:flutter/material.dart';
import 'package:quotes_poetry_flutter_app/theme/app_pallete.dart';
import 'package:quotes_poetry_flutter_app/widgets/circular_container.dart';

class TopQuoteScreenStyle extends StatelessWidget {
  const TopQuoteScreenStyle({super.key});

  @override
  Widget build(BuildContext context) {
    //final color1 = AppPalette.container1;
    final color2 = AppPalette.container2;
    final color3 = AppPalette.container3;

    final size1 = 400.0;
    final size2 = 90.0;
    final size3 = 50.0;
    final size4 = 65.0;

    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Positioned(
            left: -(size1 / 2),
            top: -(size1 / 3),
            child: CircularContainer(color: color2, size: size1),
          ),
          Positioned(
            right: 90,
            child: CircularContainer(color: color3, size: size2),
          ),
          Positioned(
            right: 20,
            child: CircularContainer(color: color3, size: size3),
          ),
          Positioned(
            right: 25,
            top: 80,
            child: CircularContainer(color: color2, size: size4),
          ),
        ],
      ),
    );
  }
}
