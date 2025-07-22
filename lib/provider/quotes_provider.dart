import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class QuotesProvider with ChangeNotifier {
  List<Map<String, dynamic>> _quotes = [];
  Map<String, dynamic>? _singleQuote;
  bool _isLoading = false;
  String? _error;

  List<Map<String, dynamic>> get quotes => _quotes;
  Map<String, dynamic>? get singleQuote => _singleQuote;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchQuotes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://zenquotes.io/api/quotes'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _quotes = data
            .map(
              (quote) => {
                'text': quote['q'] ?? 'No quote text',
                'author': quote['a'] ?? 'Unknown',
              },
            )
            .toList();
      } else {
        throw Exception('Failed to load quotes (${response.statusCode})');
      }
    } catch (e) {
      _error =
          'Failed to load quotes: ${e.toString().replaceAll('Exception: ', '')}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRandomQuote() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://zenquotes.io/api/random'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _singleQuote = {
          'text': data[0]['q'] ?? 'No quote text',
          'author': data[0]['a'] ?? 'Unknown',
        };
      } else {
        throw Exception('Failed to load quote (${response.statusCode})');
      }
    } catch (e) {
      _error =
          'Failed to load quote: ${e.toString().replaceAll('Exception: ', '')}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, dynamic>? getRandomQuoteFromList() {
    if (_quotes.isEmpty) return null;
    final random = Random();
    return _quotes[random.nextInt(_quotes.length)];
  }
}
