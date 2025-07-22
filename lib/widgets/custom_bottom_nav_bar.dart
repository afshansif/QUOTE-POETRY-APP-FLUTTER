import 'package:quotes_poetry_flutter_app/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.format_quote,
      Icons.menu_book,
      Icons.favorite,
    ];

    final List<String> labels = ['Quote', 'Poetry', 'Favorites'];

    final Color color = AppPalette.text1;

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppPalette.container1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildNavItems(
            icons,
            labels,
            selectedIndex,
            onItemTapped,
            color,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavItems(
    List<IconData> icons,
    List<String> labels,
    int selectedIndex,
    Function(int) onItemTapped,
    Color color,
  ) {
    return icons.asMap().entries.map((entry) {
      final int index = entry.key;
      final IconData icon = entry.value;
      final String label = labels[index];
      final bool isSelected = index == selectedIndex;

      return Expanded(
        child: GestureDetector(
          onTap: () => onItemTapped(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: isSelected ? color : Colors.grey),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? color : Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
