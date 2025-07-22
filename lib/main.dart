import 'package:quotes_poetry_flutter_app/pages/home_page.dart';
import 'package:quotes_poetry_flutter_app/provider/favorites_provider.dart';
import 'package:quotes_poetry_flutter_app/provider/poet_names_provider.dart';
import 'package:quotes_poetry_flutter_app/provider/quotes_provider.dart';
import 'package:quotes_poetry_flutter_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [  
        ChangeNotifierProvider(create: (_) => PoetNamesProvider()),
        ChangeNotifierProvider(create: (_) => QuotesProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AK Quotes App',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
    );
  }
}
