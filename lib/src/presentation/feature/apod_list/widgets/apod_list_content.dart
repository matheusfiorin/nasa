import 'package:flutter/material.dart';
import 'package:nasa/src/presentation/common/widgets/loading_indicator.dart';
import 'package:nasa/src/presentation/common/widgets/responsive_grid.dart';
import 'package:nasa/src/presentation/feature/apod_list/model/apod_ui_model.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/apod_list_item.dart';
import 'package:nasa/src/presentation/feature/apod_list/widgets/search_results_header.dart';

class ApodListContent extends StatelessWidget {
  final List<ApodUiModel> apods;
  final ScrollController scrollController;
  final VoidCallback onRefresh;
  final bool isLoadingMore;
  final String searchQuery;

  const ApodListContent({
    super.key,
    required this.apods,
    required this.scrollController,
    required this.onRefresh,
    required this.isLoadingMore,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: Column(
        children: [
          if (searchQuery.isNotEmpty) SearchResultsHeader(query: searchQuery),
          Expanded(
            child: ResponsiveGrid(
              scrollController: scrollController,
              children: [
                ...apods.map(
                  (apod) => ApodListItem(
                    apod: apod,
                  ),
                ),
                if (isLoadingMore)
                  const Padding(
                    key: Key('loading_more'),
                    padding: EdgeInsets.all(16.0),
                    child: LoadingIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
