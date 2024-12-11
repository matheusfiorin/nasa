import 'package:flutter/material.dart';

class ApodSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const ApodSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SearchBar(
      hintText: 'Search astronomy pictures...',
      hintStyle: WidgetStateProperty.all(
        TextStyle(
          color: theme.colorScheme.onSurface.withOpacity(0.7),
          fontSize: 16,
        ),
      ),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 16,
        ),
      ),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 16),
      ),
      onSubmitted: onSearch,
      leading: Icon(
        Icons.search,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
