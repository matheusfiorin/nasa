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

class _ApodListViewState extends State<ApodListView> {
  late final ApodListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ApodListViewModel(
      getApodList: sl(),
      searchApods: sl(),
    );
    _viewModel.loadApods();
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
            if (viewModel.isLoading) {
              return const LoadingIndicator();
            }

            if (viewModel.error.isNotEmpty) {
              return ErrorView(
                message: viewModel.error,
                onRetry: viewModel.loadApods,
              );
            }

            return RefreshIndicator(
              onRefresh: viewModel.refresh,
              child: ListView.builder(
                itemCount: viewModel.apods.length,
                itemBuilder: (context, index) {
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
