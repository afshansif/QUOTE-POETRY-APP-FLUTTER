import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'dart:convert';

class PoetNamesProvider with ChangeNotifier {
  List<String> _poetNames = [];
  bool _isLoading = false;
  String? _error;

  List<String> getPoetNames() => _poetNames;
  bool isLoading() => _isLoading;
  String? getError() => _error;

  Future<void> loadPoetNames() async {
    try {
      _setLoading(true);
      _setError(null);
      notifyListeners();

      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final names =
          manifestMap.keys
              .where((path) => path.startsWith('assets/poets/'))
              .map((path) => path.split('/')[2])
              .where((name) => name != '.DS_Store')
              .toSet()
              .toList()
            ..sort();

      _setPoetNames(names);
      _setLoading(false);
      notifyListeners();
      if (_poetNames.isEmpty) {
        print('No poet names found. Check assets/poets/ directory');
      }
    } catch (e) {
      _setError('Failed to load poet names: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      rethrow;
    }
  }

  void _setPoetNames(List<String> names) {
    _poetNames = names;
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
  }

  void _setError(String? error) {
    _error = error;
  }

  Future<List<String>> getPoetFiles(String poetName, String language) async {
    try {
      _setLoading(true);
      notifyListeners();

      // Load the asset manifest
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final files = manifestMap.keys
          .where((path) => path.startsWith('assets/poets/$poetName/$language/'))
          .where((path) => path.endsWith('.txt'))
          .toList();

      _setLoading(false);
      notifyListeners();

      if (files.isEmpty) {
        print('No text files found for poet $poetName in language $language');
      }

      return files;
    } catch (e) {
      _setError('Failed to load poet files: ${e.toString()}');
      _setLoading(false);
      notifyListeners();
      rethrow;
    }
  }
}
