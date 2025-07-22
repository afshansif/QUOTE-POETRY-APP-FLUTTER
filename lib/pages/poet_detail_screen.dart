import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes_poetry_flutter_app/pages/ghazal_content_screen.dart';
import 'package:quotes_poetry_flutter_app/theme/app_pallete.dart';
import 'package:quotes_poetry_flutter_app/widgets/top_poetry_detail.dart';
import 'package:provider/provider.dart';
import 'package:quotes_poetry_flutter_app/provider/poet_names_provider.dart';

class PoetDetailScreen extends StatefulWidget {
  const PoetDetailScreen({super.key, required this.poetName});

  final String poetName;

  @override
  State<PoetDetailScreen> createState() => _PoetDetailScreenState();
}

class _PoetDetailScreenState extends State<PoetDetailScreen> {
  String _selectedLanguage = 'en';
  List<String> _poetryFiles = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPoetryFiles();
  }

  Future<void> _loadPoetryFiles() async {
    setState(() => _isLoading = true);
    final provider = Provider.of<PoetNamesProvider>(context, listen: false);
    try {
      final files = await provider.getPoetFiles(
        widget.poetName,
        _selectedLanguage,
      );

      setState(() => _poetryFiles = files);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading poetry: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 200, child: TopPoetryDetail(title: widget.poetName)),

          Expanded(child: _buildPoetryFilesList()),
        ],
      ),
    );
  }

  Widget _buildPoetryFilesList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_poetryFiles.isEmpty) {
      return const Center(child: Text('No poetry found'));
    }
    final dividerColor = AppPalette.container3;

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: _poetryFiles.length,
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(child: Divider(color: dividerColor, thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '•••',
                style: TextStyle(fontSize: 18, color: dividerColor),
              ),
            ),
            Expanded(child: Divider(color: dividerColor, thickness: 1)),
          ],
        ),
      ),
      itemBuilder: (context, index) {
        final fileName = _formatFileName(_poetryFiles[index], widget.poetName);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListTile(
            title: Text(
              fileName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppPalette.text1,
              ),
            ),
            trailing: Icon(Icons.chevron_right, color: AppPalette.container1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () async {
              try {
                // Load the file content
                final content = await rootBundle.loadString(
                  _poetryFiles[index],
                );

                // Navigate to GhazalContentScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GhazalContentScreen(
                      title: fileName,
                      content: content,
                      ghazalId: _poetryFiles[index],
                      poetName: widget.poetName,
                    ),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error loading ghazal: ${e.toString()}'),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  String _formatFileName(String path, String? poetName) {
    // Extract base filename and remove extension
    String fileName = path.split('/').last.replaceAll('.txt', '');

    // Remove poet name and "-ghazals" suffix
    fileName = fileName
        .replaceAll('-$poetName-ghazals', '')
        .replaceAll('-$poetName', '');

    // Convert to readable title format
    return fileName
        .replaceAll('-', ' ')
        .split(' ')
        .map(
          (word) =>
              word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '',
        )
        .join(' ');
  }
}
