import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nasa/src/core/di/injection_container.dart';
import 'package:nasa/src/presentation/common/widgets/error_view.dart';
import 'package:nasa/src/presentation/common/widgets/loading_indicator.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/apod_list_controller.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_list_app_bar.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import 'widgets/apod_list_item.dart';

class ApodListScreen extends StatefulWidget {
  const ApodListScreen({super.key});

  @override
  State<ApodListScreen> createState() => _ApodListScreenState();
}

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
        appBar: ApodListAppBar(controller: _controller),
        body: Consumer<ApodListController>(
          builder: (context, controller, child) {
            final state = controller.state;

            if (state.isLoading && state.apods.isEmpty) {
              return const LoadingIndicator();
            }

            if (state.error.isNotEmpty && state.apods.isEmpty) {
              return ErrorView(
                message: state.error,
                onRetry: controller.loadApods,
              );
            }

            return RefreshIndicator(
              onRefresh: controller.refresh,
              child: Column(
                children: [
                  if (state.searchQuery.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text(
                            'Search results for: ',
                            style: theme.textTheme.bodyLarge,
                          ),
                          Text(
                            state.searchQuery,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          state.apods.length + (state.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.apods.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final apod = state.apods[index];
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
