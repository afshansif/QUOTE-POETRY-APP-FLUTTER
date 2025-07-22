import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_poetry_flutter_app/provider/favorites_provider.dart';
import 'package:quotes_poetry_flutter_app/theme/app_pallete.dart';

class GhazalContentScreen extends StatelessWidget {
  final String title;
  final String content;
  final String ghazalId;
  final String poetName;

  const GhazalContentScreen({
    super.key,
    required this.title,
    required this.content,
    required this.ghazalId,
    required this.poetName,
  });

  String _convertToSimpleEnglish(String text) {
    final Map<String, String> charMap = {
      // Vowels and special letters
      'ā': 'a', 'ī': 'i', 'ū': 'u', 'ē': 'e', 'ō': 'o',
      'ñ': 'n', 'ḍ': 'd', 'ḥ': 'h', 'ḳ': 'k', 'ṅ': 'n',
      'ṣ': 's', 'ṭ': 't', 'ž': 'z', 'ṉ': 'n', 'ṛ': 'r',
      'ḷ': 'l', 'ṯ': 't', 'ẓ': 'z', 'ġ': 'g', 'ḏ': 'd',

      // Special symbols
      '‘': "'", '’': "'", '“': '"', '”': '"', '.': '',
      '': '', '': '', '': '', '': '', '': '',

      // Urdu-specific characters
      'ہ': 'h', 'ے': 'e', 'ں': 'n', 'ھ': 'h', 'ۀ': 'h',
    };

    return text
        .split('\n')
        .map((line) {
          String convertedLine = line;
          charMap.forEach((key, value) {
            convertedLine = convertedLine.replaceAll(key, value);
          });
          convertedLine = convertedLine.replaceAll(
            RegExp(r'[^\x00-\x7F\n]'),
            '',
          );
          return convertedLine;
        })
        .join('\n');
  }

  @override
  Widget build(BuildContext context) {
    final convertedContent = _convertToSimpleEnglish(content);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.isFavorite(ghazalId);
    final convTitle = _convertToSimpleEnglish(title);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Header Section
          Container(
            height: 120, 
            decoration: BoxDecoration(gradient: AppPalette.gradient2),
            child: Stack(
              children: [
                // Back button
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_sharp),
                    color: AppPalette.text1,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                // Title
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      convTitle.length <= 8
                          ? convTitle
                          : '${convTitle.substring(0, 14)}...',
                      style: const TextStyle(
                        fontFamily: 'Farro',
                        fontSize: 24,
                        color: AppPalette.text1,
                      ),

                      maxLines: 1,
                    ),
                  ),
                ),
                // Favorite button
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    color: isFavorite ? Colors.red : AppPalette.text1,
                    onPressed: () {
                      favoritesProvider.toggleFavorite(
                        FavoriteGhazal(
                          id: ghazalId,
                          title: title,
                          content: content,
                          poetName: poetName,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Content Section
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ListView.builder(
                  itemCount: convertedContent.split('\n').length,
                  itemBuilder: (context, index) {
                    final line = convertedContent.split('\n')[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        line,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppPalette.text1,
                          fontFamily: 'Farro',
                          height: 1.8,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
