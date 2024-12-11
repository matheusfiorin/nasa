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
      hintStyle: MaterialStateProperty.all(
        TextStyle(
          color: theme.colorScheme.onSurface.withOpacity(0.7),
          fontSize: 16,
        ),
      ),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 16,
        ),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      padding: const MaterialStatePropertyAll<EdgeInsets>(
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
