import 'package:quotes_poetry_flutter_app/pages/poet_detail_screen.dart';
import 'package:quotes_poetry_flutter_app/provider/poet_names_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_poetry_flutter_app/theme/app_pallete.dart';
import 'package:quotes_poetry_flutter_app/widgets/poet_card.dart';

class PoetryScreen extends StatefulWidget {
  const PoetryScreen({super.key});

  @override
  State<PoetryScreen> createState() => _PoetryScreenState();
}

class _PoetryScreenState extends State<PoetryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PoetNamesProvider>().loadPoetNames();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  void _resetSearch() {
    _searchController.clear();
    _searchFocusNode.unfocus();
    setState(() => _searchQuery = '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PoetNamesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading()) {
          return const Center(
            child: CircularProgressIndicator(color: AppPalette.text1),
          );
        }

        if (provider.getError() != null) {
          return Center(child: Text(provider.getError()!));
        }

        final poetNames = provider.getPoetNames();
        if (poetNames.isEmpty) {
          return const Center(child: Text('No poets found'));
        }

        final filteredPoets = provider
            .getPoetNames()
            .where((poet) => poet.toLowerCase().contains(_searchQuery))
            .toList();

        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchBar(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  padding: WidgetStateProperty.all(EdgeInsets.only(left: 20)),
                  hintText: 'Search for poets...',
                  leading: const Icon(Icons.search),
                  trailing: [
                    if (_searchQuery.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _resetSearch,
                      ),
                  ],
                  side: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.focused)) {
                      return BorderSide(
                        color: AppPalette.text1.withAlpha(90),
                        width: 2,
                      );
                    }
                    return BorderSide.none;
                  }),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  itemCount: filteredPoets.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _resetSearch();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PoetDetailScreen(
                              poetName: filteredPoets[index],
                            ),
                          ),
                        );
                      },
                      child: PoetCard(
                        poetName: filteredPoets[index].toUpperCase(),
                        gradient: AppPalette.gradient1,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
