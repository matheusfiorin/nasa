import 'package:flutter/material.dart';
import 'package:nasa/src/presentation/common/widgets/error_view.dart';
import 'package:nasa/src/presentation/common/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:nasa/src/presentation/feature/apod_list/controller/apod_list_controller.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_list_content.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_list_app_bar.dart';
import 'package:nasa/src/core/di/injection_container.dart';

class ApodListScreen extends StatefulWidget {
  const ApodListScreen({super.key});

  @override
  State<ApodListScreen> createState() => _ApodListScreenState();
}

class _ApodListScreenState extends State<ApodListScreen> {
  late final ApodListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = sl<ApodListController>();
    _controller.loadApods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApodListAppBar(
        onSearch: _controller.searchApodsList,
      ),
      body: ChangeNotifierProvider.value(
        value: _controller,
        child: Consumer<ApodListController>(
          builder: (context, controller, child) {
            if (controller.state.isLoading && controller.state.apods.isEmpty) {
              return const LoadingIndicator();
            } else if (controller.state.error.isNotEmpty &&
                controller.state.apods.isEmpty) {
              return ErrorView(
                message: controller.state.error,
                onRetry: controller.loadApods,
              );
            }

            return ApodListContent(
              apods: controller.uiModels,
              scrollController: _controller.scrollController,
              onRefresh: controller.refresh,
              isLoadingMore: controller.state.isLoadingMore,
              searchQuery: controller.state.searchQuery,
            );
          },
        ),
      ),
    );
  }
}
