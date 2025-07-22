import 'package:flutter/material.dart';

import 'app_pallete.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppPalette.backgroundColor,
      titleTextStyle: TextStyle(
        color: AppPalette.text1,
        fontFamily: 'Farro',
        fontSize: 25,
      ),
    ),
    

    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppPalette.backgroundColor),
      side: BorderSide.none,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPalette.backgroundColor,
      selectedItemColor: AppPalette.text1,
      unselectedItemColor: Colors.grey,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppPalette.backgroundColor,

      shape: const CircularNotchedRectangle(),
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
    ),

    searchBarTheme: SearchBarThemeData(
      elevation: WidgetStateProperty.all(0),

      backgroundColor: WidgetStateColor.resolveWith((_)=> AppPalette.searchBarbg),
    ),
  
  );
}
