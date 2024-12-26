import 'package:flutter/material.dart';

class SearchResultsHeader extends StatelessWidget {
  final String query;

  const SearchResultsHeader({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            'Search results for: ',
            style: theme.textTheme.bodyLarge,
          ),
          Text(
            query,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
