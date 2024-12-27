import 'package:flutter/material.dart';

class ApodScrollManager {
  static const double loadMoreThreshold = 0.9;
  final ScrollController scrollController;
  final VoidCallback onLoadMore;

  ApodScrollManager({
    required this.onLoadMore,
  }) : scrollController = ScrollController();

  void init() {
    scrollController.addListener(_onScroll);
  }

  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * loadMoreThreshold) {
      onLoadMore();
    }
  }
}
