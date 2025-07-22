import 'package:flutter/material.dart';

class AppPalette {
  static const Color dustyLavender = Color(
    0xFF765D67,
  ); // Soft muted purple-gray
  static const Color deepRaspberry = Color(0xFF6D3C52); // Rich berry tone
  static const Color darkPlum = Color(0xFF4B2138); // Intense purple base
  static const Color blackberry = Color(
    0xFF1B0C1A,
  ); // Near-black with purple undertone
  static const Color twilightPurple = Color(0xFF2D222F); // Dusky neutral purple
  static const Color peachBlush = Color(0xFFFADCD5);

  static const Color backgroundColor = blackberry;
  static const Color buttomNavBarFg = dustyLavender;
  static const Color card1 = deepRaspberry;
  static const Color card2 = darkPlum;
  static const Color text1 = peachBlush;
  static const Color searchBarbg = twilightPurple;
  static const Color container1 = dustyLavender;
  static const Color container2 = deepRaspberry;
  static const Color container3 = darkPlum;

  static const gradient1 = LinearGradient(
    colors: [card1, card2],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const gradient2 = LinearGradient(
    colors: [card1, card2],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
