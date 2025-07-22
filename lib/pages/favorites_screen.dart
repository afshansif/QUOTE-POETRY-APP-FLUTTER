import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_poetry_flutter_app/pages/ghazal_content_screen.dart';
import 'package:quotes_poetry_flutter_app/provider/favorites_provider.dart';
import 'package:quotes_poetry_flutter_app/theme/app_pallete.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favoritesProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Ghazals'),
        actions: [
          if (favorites.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_forever, color: Colors.red.shade200),
              onPressed: () => _showClearAllDialog(context, favoritesProvider),
            ),
        ],
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final ghazal = favorites[index];
                  return Card(
                    color: AppPalette.backgroundColor,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppPalette.gradient2,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: ListTile(
                        title: Text(
                          ghazal.title,
                          style: TextStyle(
                            fontFamily: 'Farro',
                            fontSize: 15,
                            color: AppPalette.text1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'By ${ghazal.poetName}',
                          style: TextStyle(
                            height: 2,
                            fontFamily: 'Farro',
                            fontSize: 13,
                            color: AppPalette.text1,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red.shade100),
                          onPressed: () =>
                              favoritesProvider.removeFavorite(ghazal.id),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GhazalContentScreen(
                                title: ghazal.title,
                                content: ghazal.content,
                                ghazalId: ghazal.id,
                                poetName: ghazal.poetName,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _showClearAllDialog(BuildContext context, FavoritesProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear all favorites?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppPalette.text1),
            ),
          ),
          TextButton(
            onPressed: () {
              provider.clearAllFavorites();
              Navigator.pop(context);
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
