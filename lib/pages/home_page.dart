import 'package:quotes_poetry_flutter_app/pages/poet_screen.dart';
import 'package:quotes_poetry_flutter_app/pages/quotes_screen.dart';
import 'package:quotes_poetry_flutter_app/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'favorites_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    QuotesScreen(),
    PoetryScreen(),
    FavoritesScreen(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
