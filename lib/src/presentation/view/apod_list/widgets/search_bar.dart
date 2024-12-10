import 'package:flutter/material.dart';

class ApodSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const ApodSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        hintText: 'Search by title or date...',
        onChanged: (value) => onSearch(value),
        leading: const Icon(Icons.search),
      ),
    );
  }
}