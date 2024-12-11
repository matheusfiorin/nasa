import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nasa/src/core/di/injection_container.dart';
import 'package:nasa/src/presentation/common/widgets/error_view.dart';
import 'package:nasa/src/presentation/common/widgets/loading_indicator.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/apod_list_controller.dart';
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
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Astronomy Picture of the Day',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
          elevation: 2,
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
                      itemCount:
                      controller.apods.length + (controller.isLoadingMore ? 1 : 0),
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
