import 'package:flutter/material.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/apod_list_controller.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/search_bar.dart';

class ApodListAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ApodListController controller;

  const ApodListAppBar({
    super.key,
    required this.controller,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<ApodListAppBar> createState() => _ApodListAppBarState();
}

class _ApodListAppBarState extends State<ApodListAppBar> {
  bool _showSearch = false;

  void _toggleSearch() {
    setState(() {
      _showSearch = !_showSearch;
      if (!_showSearch) {
        widget.controller.searchApodsList('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: theme.colorScheme.surface,
      title: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedOpacity(
            opacity: _showSearch ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 250),
            child: Text(
              'Astronomy Picture of the Day',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          AnimatedSlide(
            offset: Offset(_showSearch ? 0 : 1, 0),
            duration: const Duration(milliseconds: 250),
            child: AnimatedOpacity(
              opacity: _showSearch ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              child: ApodSearchBar(
                onSearch: widget.controller.searchApodsList,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: _toggleSearch,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Icon(
              _showSearch ? Icons.close : Icons.search,
              key: ValueKey(_showSearch),
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
      elevation: 0,
    );
  }
}
