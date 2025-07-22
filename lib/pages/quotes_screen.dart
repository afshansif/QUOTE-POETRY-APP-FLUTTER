import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_poetry_flutter_app/provider/quotes_provider.dart';
import 'package:quotes_poetry_flutter_app/theme/app_pallete.dart';
import 'package:quotes_poetry_flutter_app/widgets/bottom_quotescreen_style.dart';
import 'package:quotes_poetry_flutter_app/widgets/top_quotescreen_style.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuotesProvider>().fetchRandomQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<QuotesProvider>(
        builder: (context, quoteProvider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const Expanded(flex: 2, child: TopQuoteScreenStyle()),
                Expanded(child: _buildQuoteContent(quoteProvider)),
                Expanded(
                  child: BottomQuotescreenStyle(quotesProvider: quoteProvider),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuoteContent(QuotesProvider quoteProvider) {
    if (quoteProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppPalette.text1),
      );
    }

    if (quoteProvider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 30, color: Colors.red),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                quoteProvider.error!,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    }

    return quoteProvider.singleQuote != null
        ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quoteProvider.singleQuote!['text'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "Farro",
                      color: AppPalette.text1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '- ${quoteProvider.singleQuote!['author']}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppPalette.container1,
                      fontFamily: "Farro",
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(child: Text('No quote available'));
  }
}
