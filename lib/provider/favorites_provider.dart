import 'package:flutter/foundation.dart';

class FavoriteGhazal {
  final String id;
  final String title;
  final String content;
  final String poetName;

  FavoriteGhazal({
    required this.id,
    required this.title,
    required this.content,
    required this.poetName,
  });
}

class FavoritesProvider with ChangeNotifier {
  final List<FavoriteGhazal> _favorites = [];

  List<FavoriteGhazal> get favorites => _favorites;

  void toggleFavorite(FavoriteGhazal ghazal) {
    if (_favorites.any((f) => f.id == ghazal.id)) {
      _favorites.removeWhere((f) => f.id == ghazal.id);
    } else {
      _favorites.add(ghazal);
    }
    notifyListeners();
  }

  void removeFavorite(String ghazalId) {
    _favorites.removeWhere((f) => f.id == ghazalId);
    notifyListeners();
  }

  bool isFavorite(String ghazalId) {
    return _favorites.any((f) => f.id == ghazalId);
  }

  void clearAllFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}