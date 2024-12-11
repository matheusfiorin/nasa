import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nasa/src/core/di/injection_container.dart';
import 'package:nasa/src/presentation/common/widgets/error_view.dart';
import 'package:nasa/src/presentation/common/widgets/loading_indicator.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/apod_list_controller.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import 'widgets/apod_list_item.dart';

class ApodListScreen extends StatefulWidget {
  const ApodListScreen({super.key});

  @override
  State<ApodListScreen> createState() => _ApodListScreenState();
}

Timer? _scrollDebounce;

class _ApodListScreenState extends State<ApodListScreen> {
  late final ApodListController _controller;
  final _scrollController = ScrollController();
  Timer? _scrollDebounce;
  bool _showSearch = false;

  @override
  void initState() {
    super.initState();
    _controller = ApodListController(
      getApodList: sl(),
      searchApods: sl(),
      clearCache: sl(),
    );
    _controller.loadApods();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollDebounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollDebounce?.isActive ?? false) return;

    _scrollDebounce = Timer(const Duration(milliseconds: 150), () {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 1000) {
        _controller.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        appBar: AppBar(
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
                    onSearch: (query) => _controller.searchApodsList(query),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _showSearch = !_showSearch;
                  if (!_showSearch) {
                    _controller.searchApodsList('');
                  }
                });
              },
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
        ),
        body: Consumer<ApodListController>(
          builder: (context, controller, child) {
            if (controller.isLoading && controller.apods.isEmpty) {
              return const LoadingIndicator();
            }

            if (controller.error.isNotEmpty && controller.apods.isEmpty) {
              return ErrorView(
                message: controller.error,
                onRetry: controller.loadApods,
              );
            }

            return RefreshIndicator(
              onRefresh: controller.refresh,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text('Test'),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: controller.apods.length +
                          (controller.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.apods.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final apod = controller.apods[index];
                        return ApodListItem(apod: apod);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
