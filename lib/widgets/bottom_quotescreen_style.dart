import 'package:flutter/material.dart';
import 'package:quotes_poetry_flutter_app/provider/quotes_provider.dart';
import 'package:quotes_poetry_flutter_app/theme/app_pallete.dart';
import 'package:quotes_poetry_flutter_app/widgets/circular_container.dart';

class BottomQuotescreenStyle extends StatelessWidget {
  const BottomQuotescreenStyle({super.key, required this.quotesProvider});

  final QuotesProvider quotesProvider;

  @override
  Widget build(BuildContext context) {
    final color = AppPalette.container3;
    final color1 = AppPalette.container2;
    final size = 70.0;
    final size1 = 20.0;
    final size2 = 13.0;
    return Stack(
      children: [
        Positioned(
          right: 25,
          bottom: 30,
          child: Stack(
            children: [
              CircularContainer(color: color, size: size),
              Positioned(
                top: size / 6,
                left: size / 6,
                child: IconButton(
                  onPressed: () {
                    quotesProvider.fetchRandomQuote();
                  },
                  icon: Icon(Icons.refresh, size: 23),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          child: Stack(
            children: [
              Positioned(
                bottom: 60,
                left: 30,

                child: CircularContainer(color: color1, size: size1),
              ),
              Positioned(
                bottom: 50,
                left: 20,

                child: CircularContainer(color: color1, size: size2),
              ),
              Positioned(
                bottom: 49,
                left: 40,

                child: CircularContainer(color: color1, size: size2 - 4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
