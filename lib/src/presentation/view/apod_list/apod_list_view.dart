import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nasa/src/core/di/injection_container.dart';
import 'package:nasa/src/presentation/common/widgets/error_view.dart';
import 'package:nasa/src/presentation/common/widgets/loading_indicator.dart';
import 'package:nasa/src/presentation/view/apod_list/apod_list_viewmodel.dart';
import 'package:provider/provider.dart';

import 'widgets/apod_list_item.dart';
import 'widgets/search_bar.dart';

class ApodListView extends StatefulWidget {
  const ApodListView({super.key});

  @override
  State<ApodListView> createState() => _ApodListViewState();
}

Timer? _scrollDebounce;

class _ApodListViewState extends State<ApodListView> {
  late final ApodListViewModel _viewModel;
  final _scrollController = ScrollController();
  Timer? _scrollDebounce;

  @override
  void initState() {
    super.initState();
    _viewModel = ApodListViewModel(
      getApodList: sl(),
      searchApods: sl(),
    );
    _viewModel.loadApods();
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
        _viewModel.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NASA APOD'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: ApodSearchBar(
              onSearch: _viewModel.searchApodsList,
            ),
          ),
        ),
        body: Consumer<ApodListViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading && viewModel.apods.isEmpty) {
              return const LoadingIndicator();
            }

            if (viewModel.error.isNotEmpty && viewModel.apods.isEmpty) {
              return ErrorView(
                message: viewModel.error,
                onRetry: viewModel.loadApods,
              );
            }

            return RefreshIndicator(
              onRefresh: viewModel.refresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount:
                    viewModel.apods.length + (viewModel.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == viewModel.apods.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final apod = viewModel.apods[index];
                  return ApodListItem(apod: apod);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
